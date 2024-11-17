// View 扩展
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func iOS15BackgroundStyle() -> some View {
        if #available(iOS 15.0, *) {
            return self.background(.ultraThinMaterial)
        } else {
            return self.background(Color(.systemBackground))
        }
    }
    
    func pressableStyle() -> some View {
        modifier(PressableButton())
    }
    
    func glassBackground() -> some View {
        modifier(GlassBackground())
    }
    
    func shake(with amount: CGFloat) -> some View {
        modifier(ShakeEffect(amount: amount, animatableData: amount))
    }
}

// 圆角形状
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// 日期扩展
extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
}

// 数字扩展
extension Int {
    func formattedDuration() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        return "\(hours)小时\(minutes)分钟"
    }
}

// Color 扩展
extension Color {
    static let systemBackground = Color(.systemBackground)
    static let secondarySystemBackground = Color(.secondarySystemBackground)
    static let tertiarySystemBackground = Color(.tertiarySystemBackground)
    
    static let label = Color(.label)
    static let secondaryLabel = Color(.secondaryLabel)
    static let tertiaryLabel = Color(.tertiaryLabel)
} 