import Foundation

protocol ProjectListViewModelDelegate: AnyObject {
    func shouldReloadTableView()
}

class ProjectListViewModel {
    private var networkManager: NetworkManager
    private var items: [ProjectCellViewModel] = []

    weak var delegate: ProjectListViewModelDelegate?

    init(manager: NetworkManager = NetworkManager()) {
        self.networkManager = manager
        
    }

    var numberOfItems: Int { items.count }

    func item(at index: Int) -> ProjectCellViewModel { items[index] }

    func saveProjects(data: ProjectCellViewModel) {
        ProjectListUploader.saveProjects(
            manager: networkManager)
            
        self.items.append(data)

        DispatchQueue.main.async {
            self.delegate?.shouldReloadTableView()
        }
    }
}
