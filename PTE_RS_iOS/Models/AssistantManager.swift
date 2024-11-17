import SwiftUI

class AssistantManager: ObservableObject {
    static let shared = AssistantManager()
    
    @Published var isShowingMessage = false
    @Published var currentMessage = ""
    @Published var isAnimating = false
    @Published var catEyePosition: CGPoint = .zero
    
    private let messages = [
        "太棒了！继续保持这个学习热情！🌟",
        "你已经完成了20个句子，真厉害！💪",
        "学习的路上有我陪着你，继续加油！😊",
        "看到你这么认真学习，我也很开心！✨",
        "坚持就是胜利，你做得很好！🎯",
        "每天进步一点点，你离目标更近了！🎊"
    ]
    
    private var messageTimer: Timer?
    private var eyeTrackingTimer: Timer?
    
    private init() {
        setupEyeTracking()
    }
    
    private func setupEyeTracking() {
        eyeTrackingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.updateEyePosition()
        }
    }
    
    private func updateEyePosition() {
        // 模拟眼睛随机移动
        withAnimation(.easeInOut(duration: 0.5)) {
            let randomX = CGFloat.random(in: -2...2)
            let randomY = CGFloat.random(in: -2...2)
            catEyePosition = CGPoint(x: randomX, y: randomY)
        }
    }
    
    func showRandomMessage() {
        guard let message = messages.randomElement() else { return }
        showMessage(message)
        HapticManager.shared.playSuccess()
    }
    
    func showMessage(_ message: String) {
        currentMessage = message
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            isShowingMessage = true
            isAnimating = true
        }
        
        messageTimer?.invalidate()
        messageTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] _ in
            withAnimation {
                self?.isShowingMessage = false
                self?.isAnimating = false
            }
        }
    }
    
    func checkProgress(checkedCount: Int, totalCount: Int) {
        if checkedCount > 0 && checkedCount % 20 == 0 {
            showRandomMessage()
        }
        
        if checkedCount == totalCount && totalCount > 0 {
            showMessage("恭喜你完成了所有句子的练习！真是太厉害了！🎉")
            HapticManager.shared.playSuccess()
        }
    }
    
    func showError(_ message: String) {
        withAnimation {
            currentMessage = "😅 " + message
            isShowingMessage = true
        }
        
        HapticManager.shared.playError()
        
        messageTimer?.invalidate()
        messageTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
            withAnimation {
                self?.isShowingMessage = false
            }
        }
    }
    
    deinit {
        messageTimer?.invalidate()
        eyeTrackingTimer?.invalidate()
    }
} 