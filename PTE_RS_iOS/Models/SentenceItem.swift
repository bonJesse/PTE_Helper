import Foundation

struct SentenceItem: Identifiable, Codable, Equatable {
    let id: String
    let text: String
    var isChecked: Bool
    var isStarred: Bool
    var practiceCount: Int
    var note: String?
    var timestamp: Date
    
    init(id: String = UUID().uuidString, text: String) {
        self.id = id
        self.text = text
        self.isChecked = false
        self.isStarred = false
        self.practiceCount = 0
        self.timestamp = Date()
    }
    
    static func == (lhs: SentenceItem, rhs: SentenceItem) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - 扩展功能
extension SentenceItem {
    var shouldAutoCheck: Bool {
        practiceCount >= 5 && !isChecked
    }
    
    var formattedTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }
    
    mutating func toggleCheck() {
        isChecked.toggle()
    }
    
    mutating func toggleStar() {
        isStarred.toggle()
    }
    
    mutating func incrementPracticeCount() {
        practiceCount += 1
        if shouldAutoCheck {
            isChecked = true
        }
    }
} 