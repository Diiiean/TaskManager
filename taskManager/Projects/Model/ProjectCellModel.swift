import Foundation

struct ProjectCellModel: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    
}
