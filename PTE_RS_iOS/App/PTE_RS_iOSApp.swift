@main
struct PTE_RS_iOSApp: App {
    @StateObject private var userManager = UserManager.shared
    @StateObject private var storageManager = StorageManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userManager)
                .environmentObject(storageManager)
        }
    }
} 