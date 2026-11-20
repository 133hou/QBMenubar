import SwiftUI
import AppKit

public struct AddTorrentView: View {
    @Bindable var viewModel: QBMenubarViewModel
    @State private var selectedFileURL: URL?
    @State private var parsedMeta: ParsedTorrentMeta?
    @State private var parseError: String?
    @State private var savePath: String = ""
    @State private var startImmediately: Bool = true
    @State private var isUploading: Bool = false
    @State private var uploadError: String?
    @State private var isDropTarget: Bool = false

    public init(viewModel: QBMenubarViewModel, initialFileURL: URL? = nil) {
        self.viewModel = viewModel
        self._selectedFileURL = State(initialValue: initialFileURL)
    }

    public var body: some View {
        VStack(spacing: 0) {
            // Header Bar
            HStack(spacing: 10) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(.tint)

                VStack(alignment: .leading, spacing: 2) {
                    Text("添加下载任务")
                        .font(.system(size: 15, weight: .bold))
                    Text("上传 .torrent 种子文件并确认下载内容")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button("关闭") {
                    AddTorrentWindowController.shared.close()
                }
                .keyboardShortcut(.cancelAction)
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
            .padding(.bottom, 14)
            .background(.ultraThinMaterial)

            Divider()

            if let meta = parsedMeta {
                // Confirmation & Content View
                torrentDetailsView(meta: meta)
            } else {
                // File Picker / Drop Zone View
                emptyStateDropView
            }

            Divider()

            // Bottom Action Bar
            bottomActionBar
        }
        .frame(width: 580, height: 520)
        .background(Color(NSColor.windowBackgroundColor))
        .onAppear {
            if savePath.isEmpty {
                savePath = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first?.path ?? "~/Downloads"
                Task {
                    if let defaultPath = await viewModel.service.getDefaultSavePath(), !defaultPath.isEmpty {
                        await MainActor.run {
                            self.savePath = defaultPath
                        }
                    }
                }
            }
            if let url = selectedFileURL {
                loadTorrentFile(from: url)
            }
        }
    }

    // MARK: - Drop Zone / Empty State

    private var emptyStateDropView: some View {
        VStack(spacing: 16) {
            Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(
                        isDropTarget ? Color.accentColor : Color.secondary.opacity(0.3),
                        style: StrokeStyle(lineWidth: 2, dash: [8, 6])
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(isDropTarget ? Color.accentColor.opacity(0.08) : Color.primary.opacity(0.02))
                    )

                VStack(spacing: 12) {
                    Image(systemName: "arrow.down.doc.fill")
                        .font(.system(size: 42))
                        .foregroundStyle(isDropTarget ? Color.accentColor : .secondary)

                    Text("将 .torrent 种子文件拖拽到此处")
                        .font(.system(size: 14, weight: .semibold))

                    Text("或者点击下方按钮从本地选取")
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)

                    Button("选择种子文件...") {
                        chooseFile()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.regular)
                    .padding(.top, 4)
                }
                .padding(30)
            }
            .frame(maxWidth: 480, maxHeight: 260)
            .onDrop(of: [.fileURL], isTargeted: $isDropTarget) { providers in
                guard let provider = providers.first else { return false }
                _ = provider.loadObject(ofClass: URL.self) { url, _ in
                    guard let url = url, url.pathExtension.lowercased() == "torrent" else { return }
                    DispatchQueue.main.async {
                        self.loadTorrentFile(from: url)
                    }
                }
                return true
            }

            if let error = parseError {
                HStack(spacing: 6) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.red)
                    Text(error)
                        .font(.system(size: 12))
                        .foregroundStyle(.red)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.red.opacity(0.1))
                )
            }

            Spacer()
        }
        .padding(24)
    }

    // MARK: - Torrent Details & Files Preview

    private func torrentDetailsView(meta: ParsedTorrentMeta) -> some View {
        VStack(spacing: 14) {
            // Summary Card
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: meta.isMultiFile ? "folder.fill" : "doc.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(.tint)
                        .padding(.top, 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(meta.name)
                            .font(.system(size: 14, weight: .bold))
                            .lineLimit(2)

                        HStack(spacing: 8) {
                            Text(meta.formattedTotalSize)
                                .font(.system(size: 11, weight: .semibold, design: .rounded))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Capsule().fill(Color.accentColor.opacity(0.15)))
                                .foregroundStyle(Color.accentColor)

                            Text("\(meta.files.count) 个文件")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(.secondary)

                            if let date = meta.creationDate {
                                Text("创建: \(date.formatted(date: .abbreviated, time: .omitted))")
                                    .font(.system(size: 11))
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }

                    Spacer()

                    Button {
                        chooseFile()
                    } label: {
                        Text("更换文件")
                            .font(.system(size: 11))
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                }

                if let comment = meta.comment, !comment.isEmpty {
                    Text(comment)
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.primary.opacity(0.04))
            )

            // Save Path Configuration
            HStack(spacing: 8) {
                Text("保存位置:")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.secondary)
                    .frame(width: 60, alignment: .leading)

                TextField("保存路径", text: $savePath)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 11, design: .monospaced))

                Button("浏览...") {
                    chooseSaveDirectory()
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }

            // Options: Start Immediately
            HStack {
                Toggle("添加后立即开始下载", isOn: $startImmediately)
                    .font(.system(size: 12))

                Spacer()
            }

            // File List Preview
            VStack(alignment: .leading, spacing: 6) {
                Text("下载内容列表 (\(meta.files.count) 个文件)")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.secondary)

                ScrollView {
                    LazyVStack(spacing: 4) {
                        ForEach(meta.files) { item in
                            HStack(spacing: 8) {
                                Image(systemName: item.systemIconName)
                                    .font(.system(size: 12))
                                    .foregroundStyle(.secondary)
                                    .frame(width: 16)

                                Text(item.fileName)
                                    .font(.system(size: 12))
                                    .lineLimit(1)
                                    .help(item.path)

                                Spacer()

                                Text(item.formattedSize)
                                    .font(.system(size: 11, design: .rounded))
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(Color.primary.opacity(0.02))
                            )
                        }
                    }
                    .padding(4)
                }
                .scrollIndicators(.visible)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color(NSColor.controlBackgroundColor))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                )
                .frame(maxHeight: 180)
            }

            if let uploadErr = uploadError {
                HStack(spacing: 6) {
                    Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(.red)
                    Text(uploadErr).font(.system(size: 11)).foregroundStyle(.red)
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 14)
        .padding(.bottom, 8)
    }

    // MARK: - Bottom Actions

    private var bottomActionBar: some View {
        HStack(spacing: 12) {
            if parsedMeta != nil {
                Button("重新选择") {
                    parsedMeta = nil
                    selectedFileURL = nil
                    parseError = nil
                }
                .buttonStyle(.plain)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
            }

            Spacer()

            Button("取消") {
                AddTorrentWindowController.shared.close()
            }
            .buttonStyle(.bordered)
            .disabled(isUploading)

            Button {
                startDownload()
            } label: {
                if isUploading {
                    HStack(spacing: 6) {
                        ProgressView().scaleEffect(0.6).frame(width: 12, height: 12)
                        Text("正在添加...")
                    }
                } else {
                    Text("确认开始下载")
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(parsedMeta == nil || isUploading)
            .keyboardShortcut(.defaultAction)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(.ultraThinMaterial)
    }

    // MARK: - File Pickers & Upload Actions

    private func chooseFile() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        panel.allowedContentTypes = [.init(filenameExtension: "torrent") ?? .data]
        panel.message = "请选择一个 .torrent 种子文件"
        panel.prompt = "选取"

        if panel.runModal() == .OK, let url = panel.url {
            loadTorrentFile(from: url)
        }
    }

    private func chooseSaveDirectory() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.canCreateDirectories = true
        panel.prompt = "选择保存目录"
        panel.message = "请选择文件下载保存的本地路径"

        if panel.runModal() == .OK, let url = panel.url {
            savePath = url.path
        }
    }

    private func loadTorrentFile(from url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let meta = try ParsedTorrentMeta.parse(data: data, originalFileName: url.lastPathComponent)
            self.parsedMeta = meta
            self.selectedFileURL = url
            self.parseError = nil
            self.uploadError = nil
        } catch {
            self.parseError = "种子文件解析失败: \(error.localizedDescription)"
            self.parsedMeta = nil
        }
    }

    private func startDownload() {
        guard let meta = parsedMeta else { return }
        isUploading = true
        uploadError = nil

        Task {
            do {
                try await viewModel.service.addTorrent(
                    fileData: meta.rawData,
                    fileName: meta.sourceFileName,
                    savePath: savePath.isEmpty ? nil : savePath,
                    paused: !startImmediately
                )
                await MainActor.run {
                    self.isUploading = false
                    AddTorrentWindowController.shared.close()
                    self.viewModel.bannerMessage = "🎉 已成功添加任务: \(meta.name)"
                }
                await viewModel.refresh()
            } catch {
                await MainActor.run {
                    self.isUploading = false
                    self.uploadError = "添加任务失败: \(error.localizedDescription)"
                }
            }
        }
    }
}
