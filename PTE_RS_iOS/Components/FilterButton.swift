struct FilterButton: View {
    let title: String
    let type: FilterType
    @Binding var selected: FilterType
    @State private var count: Int = 0
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selected = type
            }
            HapticManager.shared.playSelection()
        }) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.system(.body, design: .rounded))
                
                if count > 0 {
                    Text("(\(count))")
                        .font(.system(.footnote, design: .rounded))
                        .foregroundColor(selected == type ? .white.opacity(0.8) : .gray)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(selected == type ? Color.accentColor : Color(.systemGray6))
            )
            .foregroundColor(selected == type ? .white : .accentColor)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            updateCount()
        }
    }
    
    private func updateCount() {
        switch type {
        case .all:
            count = StorageManager.shared.totalCount
        case .checked:
            count = StorageManager.shared.checkedCount
        case .starred:
            count = StorageManager.shared.starredCount
        }
    }
}

// 预览
struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            FilterButton(title: "全部句子", type: .all, selected: .constant(.all))
            FilterButton(title: "已打卡", type: .checked, selected: .constant(.checked))
            FilterButton(title: "已加星", type: .starred, selected: .constant(.all))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
} 