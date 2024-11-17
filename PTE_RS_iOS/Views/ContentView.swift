import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var storageManager: StorageManager
    @EnvironmentObject var assistantManager: AssistantManager
    
    @State private var showSettings = false
    @State private var searchText = ""
    @State private var selectedFilter: FilterType = .all
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeaderView()
                
                StatsView(selectedFilter: $selectedFilter)
                
                SearchBarView(searchText: $searchText)
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(filteredSentences) { item in
                            SentenceItemView(item: item)
                        }
                    }
                    .padding()
                }
                .animation(.default, value: searchText)
                .animation(.default, value: selectedFilter)
            }
            .navigationBarItems(trailing: SettingsButton(isPresented: $showSettings))
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }
    
    private var filteredSentences: [SentenceItem] {
        let filtered = storageManager.currentData.filter { item in
            switch selectedFilter {
            case .all:
                return true
            case .checked:
                return item.isChecked
            case .starred:
                return item.isStarred
            }
        }
        
        if searchText.isEmpty {
            return filtered
        }
        
        return filtered.filter { item in
            item.text.localizedCaseInsensitiveContains(searchText)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserManager.shared)
        .environmentObject(StorageManager.shared)
        .environmentObject(AssistantManager.shared)
} 