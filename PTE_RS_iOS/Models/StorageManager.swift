import Foundation

class StorageManager: ObservableObject {
    static let shared = StorageManager()
    
    @Published var currentData: [SentenceItem] = []
    @Published var currentFileId: String?
    @Published var checkedCount = 0
    @Published var starredCount = 0
    @Published var totalCount = 0
    
    private let fileManager = FileManager.default
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private init() {}
    
    func processFile(at url: URL) throws {
        guard let data = try? Data(contentsOf: url) else {
            throw StorageError.fileReadError
        }
        
        if url.pathExtension.lowercased() == "xlsx" {
            try processExcelFile(data: data)
        } else {
            throw StorageError.unsupportedFileType
        }
    }
    
    private func processExcelFile(data: Data) throws {
        // 这里需要添加 Excel 处理逻辑
        // 可以使用第三方库如 CoreXLSX
        // 暂时使用模拟数据
        let mockSentences = [
            "This is a test sentence one.",
            "This is another test sentence.",
            "And here's the third one."
        ]
        
        currentData = mockSentences.enumerated().map { index, text in
            SentenceItem(id: UUID().uuidString, text: text)
        }
        
        updateCounts()
        try saveCurrentState()
    }
    
    func updateCounts() {
        checkedCount = currentData.filter { $0.isChecked }.count
        starredCount = currentData.filter { $0.isStarred }.count
        totalCount = currentData.count
    }
    
    func toggleCheck(for item: SentenceItem) throws {
        guard let index = currentData.firstIndex(where: { $0.id == item.id }) else {
            throw StorageError.itemNotFound
        }
        
        currentData[index].toggleCheck()
        updateCounts()
        try saveCurrentState()
    }
    
    func toggleStar(for item: SentenceItem) throws {
        guard let index = currentData.firstIndex(where: { $0.id == item.id }) else {
            throw StorageError.itemNotFound
        }
        
        currentData[index].toggleStar()
        updateCounts()
        try saveCurrentState()
    }
    
    func updatePracticeCount(for item: SentenceItem) throws {
        guard let index = currentData.firstIndex(where: { $0.id == item.id }) else {
            throw StorageError.itemNotFound
        }
        
        currentData[index].incrementPracticeCount()
        try saveCurrentState()
    }
    
    func updateNote(for item: SentenceItem, note: String) throws {
        guard let index = currentData.firstIndex(where: { $0.id == item.id }) else {
            throw StorageError.itemNotFound
        }
        
        currentData[index].note = note
        try saveCurrentState()
    }
    
    private func saveCurrentState() throws {
        guard let fileId = currentFileId else {
            throw StorageError.noActiveFile
        }
        
        let data = try encoder.encode(currentData)
        let fileURL = try getDocumentURL(for: fileId)
        try data.write(to: fileURL)
    }
    
    func loadSavedState(for fileId: String) throws {
        let fileURL = try getDocumentURL(for: fileId)
        let data = try Data(contentsOf: fileURL)
        currentData = try decoder.decode([SentenceItem].self, from: data)
        currentFileId = fileId
        updateCounts()
    }
    
    private func getDocumentURL(for fileId: String) throws -> URL {
        let documentsDirectory = try fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        return documentsDirectory.appendingPathComponent("\(fileId).json")
    }
}

// MARK: - Error Types
extension StorageManager {
    enum StorageError: LocalizedError {
        case fileReadError
        case unsupportedFileType
        case itemNotFound
        case noActiveFile
        case encodingError
        case decodingError
        
        var errorDescription: String? {
            switch self {
            case .fileReadError:
                return "无法读取文件"
            case .unsupportedFileType:
                return "不支持的文件类型"
            case .itemNotFound:
                return "找不到指定的句子"
            case .noActiveFile:
                return "没有活动的文件"
            case .encodingError:
                return "数据编码错误"
            case .decodingError:
                return "数据解码错误"
            }
        }
    }
} 