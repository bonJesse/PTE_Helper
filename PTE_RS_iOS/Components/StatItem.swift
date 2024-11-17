struct StatItem: View {
    let value: Int
    let title: String
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 4) {
            Text("\(value)")
                .font(.system(.title2, design: .rounded, weight: .bold))
                .foregroundColor(.accentColor)
                .scaleEffect(animate ? 1 : 0.8)
                .animation(.spring(response: 0.4, dampingFraction: 0.7), value: animate)
            
            Text(title)
                .font(.system(.caption, design: .rounded))
                .foregroundColor(.secondary)
        }
        .onAppear {
            animate = true
        }
        .onChange(of: value) { _ in
            animate = false
            withAnimation {
                animate = true
            }
        }
    }
}

#Preview {
    HStack {
        StatItem(value: 12, title: "今日已打卡")
        StatItem(value: 30, title: "剩余句子")
    }
    .padding()
    .previewLayout(.sizeThatFits)
} 