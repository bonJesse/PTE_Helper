struct LogoView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // 背景渐变
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.blue, .purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 80, height: 80)
                .overlay(
                    // 玻璃态效果
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                        .opacity(0.3)
                )
                .overlay(
                    // 水滴效果
                    Circle()
                        .fill(.white.opacity(0.3))
                        .frame(width: 15, height: 15)
                        .blur(radius: 2)
                        .offset(x: -25, y: -25)
                )
            
            CatFaceView()
            
            // RS 标签
            Text("RS")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .padding(6)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .offset(y: 30)
        }
        .shadow(radius: 10)
    }
} 