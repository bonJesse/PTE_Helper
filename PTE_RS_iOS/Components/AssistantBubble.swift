struct AssistantBubble: View {
    let message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        if isShowing {
            VStack {
                Text(message)
                    .font(.system(.body, design: .rounded))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemBackground))
                            .shadow(color: Color.black.opacity(0.1), radius: 10)
                    )
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.bottom, 20)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isShowing = false
                    }
                }
            }
        }
    }
}

#Preview {
    AssistantBubble(message: "太棒了！继续保持这个学习热情！🌟", isShowing: .constant(true))
} 