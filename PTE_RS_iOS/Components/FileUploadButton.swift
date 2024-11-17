struct FileUploadButton: View {
    @EnvironmentObject var storageManager: StorageManager
    @State private var isShowingDocumentPicker = false
    @State private var isAnimating = false
    
    var body: some View {
        Button(action: {
            isShowingDocumentPicker = true
        }) {
            HStack(spacing: 8) {
                Image(systemName: "arrow.up.doc")
                    .font(.system(size: 20))
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                
                Text("上传文件")
                    .font(.system(.body, design: .rounded))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray6))
            )
            .foregroundColor(.accentColor)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever()) {
                isAnimating = true
            }
        }
        .fileImporter(
            isPresented: $isShowingDocumentPicker,
            allowedContentTypes: [.spreadsheet],
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case .success(let urls):
                if let url = urls.first {
                    handleFileImport(url)
                }
            case .failure(let error):
                print("Error importing file:", error)
            }
        }
    }
    
    private func handleFileImport(_ url: URL) {
        do {
            try storageManager.processFile(at: url)
        } catch {
            print("Error processing file:", error)
        }
    }
} 