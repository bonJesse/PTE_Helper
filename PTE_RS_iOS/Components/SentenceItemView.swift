struct SentenceItemView: View {
    @EnvironmentObject var storageManager: StorageManager
    @State private var showNote = false
    @State private var noteText = ""
    let item: SentenceItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(item.text)")
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack(spacing: 16) {
                // 打卡按钮
                Button(action: { toggleCheck() }) {
                    Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.isChecked ? .green : .gray)
                        .imageScale(.small)
                }
                
                // 练习按钮
                Button(action: { incrementPractice() }) {
                    Image(systemName: "play.circle")
                        .foregroundColor(.blue)
                        .imageScale(.small)
                }
                
                // 加星按钮
                Button(action: { toggleStar() }) {
                    Image(systemName: item.isStarred ? "star.fill" : "star")
                        .foregroundColor(item.isStarred ? .yellow : .gray)
                        .imageScale(.small)
                }
                
                // 备注按钮
                Button(action: { showNote.toggle() }) {
                    Image(systemName: "note.text")
                        .foregroundColor(.gray)
                        .imageScale(.small)
                }
            }
            
            if showNote {
                TextField("添加备注...", text: $noteText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        try? storageManager.updateNote(for: item, note: noteText)
                        showNote = false
                    }
            }
            
            // 练习次数
            Text("\(item.practiceCount)")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .onAppear {
            noteText = item.note ?? ""
        }
    }
    
    private func toggleCheck() {
        try? storageManager.toggleCheck(for: item)
        HapticManager.shared.playSelection()
    }
    
    private func toggleStar() {
        try? storageManager.toggleStar(for: item)
        HapticManager.shared.playSelection()
    }
    
    private func incrementPractice() {
        try? storageManager.updatePracticeCount(for: item)
        HapticManager.shared.playSelection()
    }
} 