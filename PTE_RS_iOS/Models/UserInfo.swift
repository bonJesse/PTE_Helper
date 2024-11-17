import Foundation

struct UserInfo: Codable, Equatable {
    var userId: String
    var deviceInfo: DeviceInfo
    var created: Date
    var lastVisit: Date
    var visits: Int
    var fileHistory: [FileRecord]
    var learningStats: LearningStats
    
    struct DeviceInfo: Codable, Equatable {
        var userAgent: String
        var platform: String
        var screenSize: String
        var language: String
        var systemVersion: String
        
        static func current() -> DeviceInfo {
            DeviceInfo(
                userAgent: UIDevice.current.systemName,
                platform: UIDevice.current.model,
                screenSize: "\(UIScreen.main.bounds.size)",
                language: Locale.current.languageCode ?? "unknown",
                systemVersion: UIDevice.current.systemVersion
            )
        }
    }
    
    struct LearningStats: Codable, Equatable {
        var totalPracticed: Int
        var totalChecked: Int
        var practiceTime: TimeInterval
        var consecutiveDays: Int
        var lastPracticeDate: Date?
        var dailyGoal: Int
        var weeklyGoal: Int
        
        static func defaultStats() -> LearningStats {
            LearningStats(
                totalPracticed: 0,
                totalChecked: 0,
                practiceTime: 0,
                consecutiveDays: 0,
                lastPracticeDate: nil,
                dailyGoal: 20,
                weeklyGoal: 100
            )
        }
        
        var formattedPracticeTime: String {
            let hours = Int(practiceTime) / 3600
            let minutes = Int(practiceTime) / 60 % 60
            return "\(hours)小时\(minutes)分钟"
        }
    }
    
    struct FileRecord: Codable, Identifiable, Equatable {
        let id: String
        var name: String
        var uploadTime: Date
        var lastAccess: Date
        var practiceCount: Int
        var checkedCount: Int
        var totalSentences: Int
        var starredCount: Int
        
        var progress: Double {
            guard totalSentences > 0 else { return 0 }
            return Double(checkedCount) / Double(totalSentences)
        }
    }
    
    static func createNew(userId: String) -> UserInfo {
        UserInfo(
            userId: userId,
            deviceInfo: DeviceInfo.current(),
            created: Date(),
            lastVisit: Date(),
            visits: 1,
            fileHistory: [],
            learningStats: LearningStats.defaultStats()
        )
    }
} 