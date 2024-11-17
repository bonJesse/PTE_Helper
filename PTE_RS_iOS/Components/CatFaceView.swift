struct CatFaceView: View {
    @State private var eyeOffset: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 猫耳朵
                CatEarsView()
                
                // 猫脸
                Circle()
                    .fill(.white)
                    .frame(width: geometry.size.width * 0.8,
                           height: geometry.size.width * 0.8)
                    .position(x: geometry.size.width/2,
                             y: geometry.size.height/2)
                
                // 眼睛
                HStack(spacing: geometry.size.width * 0.2) {
                    CatEyeView()
                        .offset(eyeOffset)
                    CatEyeView()
                        .offset(eyeOffset)
                }
                .position(x: geometry.size.width/2,
                         y: geometry.size.height * 0.45)
                
                // 嘴巴
                CatMouthView()
                    .position(x: geometry.size.width/2,
                             y: geometry.size.height * 0.65)
            }
            .onAppear {
                startEyeAnimation()
            }
        }
    }
    
    private func startEyeAnimation() {
        // 眨眼动画
        let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.1)) {
                eyeOffset.height = 2
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    eyeOffset.height = 0
                }
            }
        }
    }
}

// 猫耳朵视图
struct CatEarsView: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: geometry.size.width * 0.4) {
                Triangle()
                    .fill(.white)
                    .frame(width: geometry.size.width * 0.2,
                           height: geometry.size.width * 0.3)
                    .rotationEffect(.degrees(-30))
                
                Triangle()
                    .fill(.white)
                    .frame(width: geometry.size.width * 0.2,
                           height: geometry.size.width * 0.3)
                    .rotationEffect(.degrees(30))
            }
            .position(x: geometry.size.width/2,
                     y: geometry.size.height * 0.2)
        }
    }
}

// 猫眼睛视图
struct CatEyeView: View {
    var body: some View {
        Circle()
            .fill(LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9490196078, blue: 0.9960784314, alpha: 1))]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .frame(width: 12, height: 12)
            .shadow(color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0.5)), radius: 5)
    }
}

// 猫嘴巴视图
struct CatMouthView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addQuadCurve(
                to: CGPoint(x: 20, y: 0),
                control: CGPoint(x: 10, y: 8)
            )
        }
        .stroke(Color(#colorLiteral(red: 0.1764705926, green: 0.1921568662, blue: 0.9803921569, alpha: 1)), lineWidth: 2)
        .frame(width: 20, height: 8)
    }
}

// 三角形形状
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
} 