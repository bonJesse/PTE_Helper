struct StatsView: View {
    @EnvironmentObject var storageManager: StorageManager
    @Binding var selectedFilter: FilterType
    @State private var showClearAlert = false
    
    enum FilterType {
        case all, checked, starred
    }
    
    var body: some View {
        VStack(spacing: 12) {
            FilterButtonGroup(selectedFilter: $selectedFilter)
            
            HStack {
                StatItem(value: storageManager.checkedCount, title: "今日已打卡")
                StatItem(value: storageManager.totalCount - storageManager.checkedCount, title: "剩余句子")
                
                Spacer()
                
                Button(action: { showClearAlert = true }) {
                    Label("清除今日打卡", systemImage: "trash")
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .alert(isPresented: $showClearAlert) {
            Alert(
                title: Text("确认清除"),
                message: Text("确定要清除今日打卡记录吗？"),
                primaryButton: .destructive(Text("确定")) {
                    // 清除打卡记录
                },
                secondaryButton: .cancel(Text("取消"))
            )
        }
    }
} 