struct FilterButtonGroup: View {
    @Binding var selectedFilter: FilterType
    @State private var animateButtons = false
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach([FilterType.all, .checked, .starred], id: \.self) { type in
                FilterButton(
                    title: type.title,
                    type: type,
                    selected: $selectedFilter
                )
                .scaleEffect(animateButtons ? 1 : 0.8)
                .opacity(animateButtons ? 1 : 0)
                .animation(
                    .spring(response: 0.4, dampingFraction: 0.7)
                    .delay(Double(type.index) * 0.1),
                    value: animateButtons
                )
            }
        }
        .onAppear {
            withAnimation {
                animateButtons = true
            }
        }
    }
}

extension FilterType {
    var title: String {
        switch self {
        case .all: return "全部句子"
        case .checked: return "已打卡"
        case .starred: return "已加星"
        }
    }
    
    var index: Int {
        switch self {
        case .all: return 0
        case .checked: return 1
        case .starred: return 2
        }
    }
}

#Preview {
    FilterButtonGroup(selectedFilter: .constant(.all))
        .padding()
        .previewLayout(.sizeThatFits)
} 