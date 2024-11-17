import SwiftUI

// 震动效果
struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

// 玻璃态背景
struct GlassBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// 按钮按压效果
struct PressableButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaleEffect(1.0)
            .animation(.easeInOut(duration: 0.2), value: true)
            .pressEvents {
                withAnimation(.easeInOut(duration: 0.1)) {
                    content.scaleEffect(0.95)
                }
            } onRelease: {
                withAnimation(.easeInOut(duration: 0.1)) {
                    content.scaleEffect(1.0)
                }
            }
    }
}

// 安全区域适配
struct SafeAreaInsetModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) { Color.clear.frame(height: 0) }
            .safeAreaInset(edge: .top) { Color.clear.frame(height: 0) }
    }
}

// 导航栏样式
struct NavigationBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(.systemBackground), for: .navigationBar)
    }
}

// 列表样式
struct ListStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(InsetGroupedListStyle())
            .scrollContentBackground(.hidden)
    }
}

extension View {
    func pressableStyle() -> some View {
        modifier(PressableButton())
    }
    
    func glassBackground() -> some View {
        modifier(GlassBackground())
    }
    
    func shake(with amount: CGFloat) -> some View {
        modifier(ShakeEffect(amount: amount, animatableData: amount))
    }
    
    func adaptiveSafeArea() -> some View {
        modifier(SafeAreaInsetModifier())
    }
    
    func navigationBarStyle() -> some View {
        modifier(NavigationBarModifier())
    }
    
    func listStyle() -> some View {
        modifier(ListStyleModifier())
    }
} 