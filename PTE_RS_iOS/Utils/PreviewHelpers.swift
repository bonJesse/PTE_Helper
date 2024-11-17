import SwiftUI

struct PreviewData {
    static let sampleSentences = [
        SentenceItem(text: "This is a test sentence one."),
        SentenceItem(text: "This is another test sentence."),
        SentenceItem(text: "And here's the third one.")
    ]
    
    static let sampleUserInfo = UserInfo(
        userId: "preview-user",
        deviceInfo: .init(
            userAgent: "iOS",
            platform: "iPhone",
            screenSize: "390x844",
            language: "en",
            systemVersion: "16.0"
        ),
        created: Date(),
        lastVisit: Date(),
        visits: 5,
        fileHistory: [
            .init(
                id: "file1",
                name: "Test File 1",
                uploadTime: Date(),
                lastAccess: Date(),
                practiceCount: 10,
                checkedCount: 5,
                totalSentences: 20,
                starredCount: 3
            ),
            .init(
                id: "file2",
                name: "Test File 2",
                uploadTime: Date(),
                lastAccess: Date(),
                practiceCount: 8,
                checkedCount: 3,
                totalSentences: 15,
                starredCount: 2
            )
        ],
        learningStats: .init(
            totalPracticed: 50,
            totalChecked: 30,
            practiceTime: 3600,
            consecutiveDays: 3,
            lastPracticeDate: Date(),
            dailyGoal: 20,
            weeklyGoal: 100
        )
    )
}

extension View {
    func previewAsScreen() -> some View {
        self
            .environmentObject(UserManager.shared)
            .environmentObject(StorageManager.shared)
            .environmentObject(AssistantManager.shared)
    }
    
    func previewAsComponent() -> some View {
        self
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

#if DEBUG
struct PreviewContainer<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .previewAsScreen()
    }
}
#endif 