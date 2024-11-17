struct SettingsButton: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                isPresented = true
            }
        }) {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 20))
                .foregroundColor(.accentColor)
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
    }
} 