import UIKit

class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    func playSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
    }
    
    func playError() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.error)
    }
    
    func playSelection() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    func playImpact(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func prepare() {
        let selection = UISelectionFeedbackGenerator()
        let notification = UINotificationFeedbackGenerator()
        let impact = UIImpactFeedbackGenerator()
        
        selection.prepare()
        notification.prepare()
        impact.prepare()
    }
} 