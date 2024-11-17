class FileProcessor {
    static let shared = FileProcessor()
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private init() {}
    
    func processExcelFile(at url: URL) throws -> [SentenceItem] {
        // 这里需要添加 Excel 处理逻辑
        // 可以使用第三方库如 CoreXLSX
        // 暂时返回模拟数据
        return [
            SentenceItem(text: "This is a test sentence one."),
            SentenceItem(text: "This is another test sentence."),
            SentenceItem(text: "And here's the third one.")
        ]
    }
    
    func saveToFile(_ items: [SentenceItem], fileId: String) throws {
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(fileId).json")
        let data = try encoder.encode(items)
        try data.write(to: fileURL)
    }
    
    func loadFromFile(fileId: String) throws -> [SentenceItem] {
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(fileId).json")
        let data = try Data(contentsOf: fileURL)
        return try decoder.decode([SentenceItem].self, from: data)
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
} 