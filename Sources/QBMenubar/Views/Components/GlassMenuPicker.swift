import SwiftUI

public struct GlassMenuPicker<T: Hashable>: View {
    @Binding public var selection: T
    public let items: [(tag: T, title: String)]
    public var width: CGFloat = 160
    @State private var isHovered: Bool = false

    public init(
        selection: Binding<T>,
        items: [(tag: T, title: String)],
        width: CGFloat = 160
    ) {
        self._selection = selection
        self.items = items
        self.width = width
    }

    private var currentTitle: String {
        items.first(where: { $0.tag == selection })?.title ?? ""
    }

    public var body: some View {
        Menu {
            ForEach(0..<items.count, id: \.self) { index in
                let item = items[index]
                Button {
                    selection = item.tag
                } label: {
                    if selection == item.tag {
                        Label(item.title, systemImage: "checkmark")
                    } else {
                        Text(item.title)
                    }
                }
            }
        } label: {
            HStack(spacing: 6) {
                Text(currentTitle)
                    .font(.system(size: 12))
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                Spacer(minLength: 4)

                Image(systemName: "chevron.up.chevron.down")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 9)
            .padding(.vertical, 5)
            .frame(width: width)
            .background(
                RoundedRectangle(cornerRadius: 7, style: .continuous)
                    .fill(Color.primary.opacity(isHovered ? 0.09 : 0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 7, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(isHovered ? 0.35 : 0.22),
                                Color.white.opacity(isHovered ? 0.10 : 0.05)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 0.65
                    )
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}
