struct HeaderView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var showFileImporter = false
    
    var body: some View {
        HStack(spacing: 20) {
            LogoView()
            
            Spacer()
            
            FileUploadButton(showFileImporter: $showFileImporter)
        }
        .padding()
        .background(Color(.systemBackground))
        .fileImporter(
            isPresented: $showFileImporter,
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
        // 处理文件导入
    }
} 