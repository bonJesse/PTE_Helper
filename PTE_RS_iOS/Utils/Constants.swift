enum Constants {
    // 颜色
    static let accentColor = Color("AccentColor")
    static let backgroundColor = Color(.systemBackground)
    static let secondaryBackgroundColor = Color(.secondarySystemBackground)
    
    // 尺寸
    static let cornerRadius: CGFloat = 12
    static let spacing: CGFloat = 16
    static let iconSize: CGFloat = 24
    
    // 动画
    static let defaultAnimation = Animation.spring(response: 0.3, dampingFraction: 0.7)
    static let messageDisplayDuration: TimeInterval = 3
    
    // 存储键
    struct StorageKeys {
        static let userInfo = "userInfo"
        static let filePrefix = "file_"
        static let sentencePrefix = "sentences_"
    }
    
    // 文件限制
    static let maxFileSize: Int64 = 10 * 1024 * 1024 // 10MB
    static let supportedFileTypes: [UTType] = [.spreadsheet]
    
    // 界面文本
    struct Text {
        static let appName = "PTE_RS_助手"
        static let version = "v1.0.4"
        static let uploadHint = "点击或拖拽上传Excel文件"
        static let supportedFormats = "支持 .xlsx 格式"
        static let clearConfirmTitle = "确认清除"
        static let clearConfirmMessage = "确定要清除今日打卡记录吗？"
        static let confirm = "确定"
        static let cancel = "取消"
    }
} 