import Foundation

struct ProjectCellViewModel: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    
}
