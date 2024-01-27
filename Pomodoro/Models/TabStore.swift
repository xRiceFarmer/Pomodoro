import Foundation

@MainActor
class TabStore: ObservableObject{
    @Published var tabs: [TabDetails] = TabDetails.defaultData
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("tabs.data")
    }
    
    func load() async throws {
        let task = Task<[TabDetails], Error>{
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return TabDetails.defaultData
            }
            let tabDetails = try JSONDecoder().decode([TabDetails].self, from: data)
            return tabDetails
        }
        let tabs = try await task.value
        self.tabs=tabs
        
    }
    
    func save(tabs: [TabDetails]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(tabs)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
