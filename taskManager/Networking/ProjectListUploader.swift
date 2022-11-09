import Foundation

struct ProjectListUploader {
    static func saveProjects(
        manager: NetworkManager = NetworkManager()
    ) {
        guard let url = URL(string: UserDefaults.standard.value(forKey: "serverURL") as! String) else { return }
        manager.makeRequest(
            with: url)
        
    }
}


