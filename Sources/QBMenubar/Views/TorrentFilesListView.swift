import SwiftUI

public struct TorrentFilesListView: View {
    public var files: [TorrentFile]?
    public var isLoading: Bool

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("内部包含文件")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)

                Spacer()

                if isLoading {
                    ProgressView()
                        .scaleEffect(0.6)
                        .frame(width: 14, height: 14)
                } else if let files = files {
                    Text("\(files.count) 个文件")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }

            if let files = files, !files.isEmpty {
                VStack(spacing: 4) {
                    ForEach(files.prefix(15)) { file in
                        HStack(spacing: 6) {
                            Image(systemName: file.systemIconName)
                                .font(.system(size: 11))
                                .foregroundStyle(.secondary)
                                .frame(width: 14)

                            Text(file.fileName)
                                .font(.system(size: 11, design: .monospaced))
                                .lineLimit(1)
                                .truncationMode(.middle)
                                .foregroundStyle(.primary)

                            Spacer()

                            Text(file.formattedSize)
                                .font(.system(size: 10, design: .rounded))
                                .foregroundStyle(.secondary)

                            Text(String(format: "%.0f%%", file.progress * 100))
                                .font(.system(size: 10, weight: .medium, design: .rounded))
                                .foregroundStyle(file.progress >= 1.0 ? .green : .secondary)
                                .frame(width: 32, alignment: .trailing)
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(Color.primary.opacity(0.03))
                        )
                    }

                    if files.count > 15 {
                        Text("… 及其他 \(files.count - 15) 个文件")
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                            .padding(.top, 2)
                    }
                }
            } else if !isLoading {
                Text("无法获取文件列表或尚未解析完成")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 4)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color.black.opacity(0.12))
        )
    }
}
