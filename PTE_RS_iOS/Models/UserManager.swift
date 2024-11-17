import Foundation
import UIKit

class UserManager: ObservableObject {
    static let shared = UserManager()
    
    @Published var userInfo: UserInfo?
    @Published var isInitialized = false
    
    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private init() {
        initializeUser()
    }
    
    private func initializeUser() {
        Task {
            do {
                let deviceId = try await generateDeviceId()
                if let storedInfo = loadUserInfo(for: deviceId) {
                    userInfo = storedInfo
                } else {
                    userInfo = UserInfo.createNew(userId: deviceId)
                }
                updateVisitCount()
                isInitialized = true
            } catch {
                print("Error initializing user:", error)
            }
        }
    }
    
    private func generateDeviceId() async throws -> String {
        let deviceInfo = [
            UIDevice.current.identifierForVendor?.uuidString ?? "",
            UIDevice.current.systemName,
            UIDevice.current.systemVersion,
            UIScreen.main.bounds.size.description,
            TimeZone.current.identifier,
            Locale.current.identifier
        ].joined()
        
        let data = Data(deviceInfo.utf8)
        let hash = await SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    private func loadUserInfo(for deviceId: String) -> UserInfo? {
        guard let data = defaults.data(forKey: "userInfo_\(deviceId)") else {
            return nil
        }
        return try? decoder.decode(UserInfo.self, from: data)
    }
    
    private func saveUserInfo() {
        guard let userInfo = userInfo,
              let data = try? encoder.encode(userInfo) else {
            return
        }
        defaults.set(data, forKey: "userInfo_\(userInfo.userId)")
    }
    
    func updateVisitCount() {
        guard var info = userInfo else { return }
        let now = Date()
        if let lastVisit = Calendar.current.date(byAdding: .hour, value: -1, to: now),
           info.lastVisit < lastVisit {
            info.visits += 1
            info.lastVisit = now
            userInfo = info
            saveUserInfo()
        }
    }
    
    func updateLearningStats(practiced: Int = 0, checked: Int = 0, time: TimeInterval = 0) {
        guard var info = userInfo else { return }
        
        let today = Calendar.current.startOfDay(for: Date())
        if let lastPractice = info.learningStats.lastPracticeDate {
            let isConsecutive = Calendar.current.isDate(lastPractice, inSameDayAs: 
                Calendar.current.date(byAdding: .day, value: -1, to: today) ?? today)
            
            if isConsecutive {
                info.learningStats.consecutiveDays += 1
            } else {
                info.learningStats.consecutiveDays = 1
            }
        } else {
            info.learningStats.consecutiveDays = 1
        }
        
        info.learningStats.lastPracticeDate = today
        info.learningStats.totalPracticed += practiced
        info.learningStats.totalChecked += checked
        info.learningStats.practiceTime += time
        
        userInfo = info
        saveUserInfo()
    }
    
    func addFileHistory(_ file: UserInfo.FileRecord) {
        guard var info = userInfo else { return }
        
        if let index = info.fileHistory.firstIndex(where: { $0.id == file.id }) {
            info.fileHistory[index].lastAccess = Date()
            info.fileHistory[index].practiceCount += 1
        } else {
            info.fileHistory.insert(file, at: 0)
            if info.fileHistory.count > 10 {
                info.fileHistory.removeLast()
            }
        }
        
        userInfo = info
        saveUserInfo()
    }
    
    func clearUserData() {
        guard let userInfo = userInfo else { return }
        defaults.removeObject(forKey: "userInfo_\(userInfo.userId)")
        self.userInfo = UserInfo.createNew(userId: userInfo.userId)
        saveUserInfo()
    }
}

// MARK: - Crypto Helper
private enum SHA256 {
    static func hash(data: Data) async -> [UInt8] {
        var hashData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = hashData.withUnsafeMutableBytes { hashBytes in
            data.withUnsafeBytes { dataBytes in
                CC_SHA256(dataBytes.baseAddress, CC_LONG(data.count), hashBytes.baseAddress?.assumingMemoryBound(to: UInt8.self))
            }
        }
        return Array(hashData)
    }
} 