struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("用户信息")) {
                    InfoRow(title: "设备ID", value: userManager.userId.prefix(8) + "...")
                    InfoRow(title: "访问次数", value: "\(userManager.userInfo?.visits ?? 0)")
                    InfoRow(title: "最近访问", value: formatDate(userManager.userInfo?.lastVisit))
                }
                
                Section(header: Text("学习统计")) {
                    if let stats = userManager.userInfo?.learningStats {
                        InfoRow(title: "总练习次数", value: "\(stats.totalPracticed)")
                        InfoRow(title: "已打卡句子", value: "\(stats.totalChecked)")
                        InfoRow(title: "学习时长", value: stats.formattedPracticeTime)
                        InfoRow(title: "连续打卡", value: "\(stats.consecutiveDays)天")
                    }
                }
                
                Section(header: Text("文件历史")) {
                    if let fileHistory = userManager.userInfo?.fileHistory {
                        ForEach(fileHistory) { file in
                            FileHistoryRow(file: file)
                        }
                    } else {
                        Text("暂无文件记录")
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("高级设置")
            .navigationBarItems(trailing: Button("完成") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
    }
}

struct FileHistoryRow: View {
    let file: UserInfo.FileRecord
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(file.name)
                .font(.headline)
            
            HStack {
                Text("练习次数: \(file.practiceCount)")
                Text("已打卡: \(file.checkedCount)")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            ProgressView(value: file.progress)
                .tint(.blue)
            
            Text(formatDate(file.lastAccess))
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
} 