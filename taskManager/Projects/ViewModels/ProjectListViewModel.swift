import Foundation

protocol ProjectListViewModelDelegate: AnyObject {
    func shouldReloadTableView()
}

final class ProjectListViewModel {
    static var shared = ProjectListViewModel()
    private var networkManager: NetworkManager
    private var items: [ProjectCellModel] = []

    weak var delegate: ProjectListViewModelDelegate?

    init(manager: NetworkManager = NetworkManager()) {
        self.networkManager = manager
        
    }

    var numberOfItems: Int { items.count }

    func item(at index: Int) -> ProjectCellModel { items[index] }

    func saveProjects(data: ProjectCellModel) {
        ProjectListUploader.saveProjects(
            manager: networkManager)
        //задержка (1000мс)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {}
        self.items.append(data)
print(items)
        DispatchQueue.main.async {
            self.delegate?.shouldReloadTableView()
        }
    }
}
