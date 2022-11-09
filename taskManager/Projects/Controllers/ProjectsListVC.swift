import UIKit

final class ProjectsListVC: UIViewController {
    
    private var projectsTableView: UITableView = {
                let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.identifier)
                return tableView
    }()
    private lazy var activityLoader: UIActivityIndicatorView = {
           let loader = UIActivityIndicatorView()
           loader.style = .medium
           loader.hidesWhenStopped = true
           return loader
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpView()
        setupNavigationBar()
        configureTableView()
        updateProjects()

    }
    func updateProjects() {
        
    }
    //Selectors
    @objc func addButtTapped() {
        let projectEntryVC = ProjectEntryVC()
        projectEntryVC.title = "Новый проект"
        navigationController?.pushViewController(projectEntryVC, animated: true)
    }
    @objc func refresh() {

      // refresh the tableView
        print("viewModel.numberOfItems  \(ProjectListViewModel.shared.numberOfItems)")
        self.projectsTableView.reloadData()

   }
}
// MARK: - Setup
private extension ProjectsListVC {
    func setUp() {
        projectsTableView.delegate = self
        projectsTableView.dataSource = self
       // viewModel.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }

    func setUpView() {
        view.backgroundColor = .systemBackground
    }
    func setupNavigationBar() {
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .always
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: activityLoader)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить",
                                                            style: .done, target: self,
                                                            action: #selector(addButtTapped))
    }
}
// MARK: - Layout
private extension ProjectsListVC {
    func configureTableView() {
        view.addSubview(projectsTableView)
        //Constraints
        setTableViewConstraints()
    }
    
    func setTableViewConstraints() {
        NSLayoutConstraint.activate([
            //Projects Butt
           projectsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
           projectsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
           projectsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ProjectsListVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Setting max number of rows according settings recordsCountTextField input
//        guard let numOfRows = Int(UserDefaults.standard.value(forKey: "recordsCount") as! String)  else { return 0 }
//
//        return  numOfRows
       
        return ProjectListViewModel.shared.numberOfItems
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let projectCell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.identifier, for: indexPath) as! ProjectTableViewCell
//        if let item = projects?[indexPath.item] {
//            projectCell.viewModel = item
//                    projectCell.selectionStyle = .none
//                }
//        return projectCell
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProjectTableViewCell.identifier,
            for: indexPath
        ) as? ProjectTableViewCell else { return UITableViewCell() }
//        cell.viewModel = viewModel.item(at: indexPath.row)
        cell.viewModel = ProjectListViewModel.shared.item(at: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
}

// MARK: - UserListViewModelDelegate
extension ProjectsListVC: ProjectListViewModelDelegate {
    func shouldReloadTableView() {
        activityLoader.stopAnimating()
        projectsTableView.reloadData()
    }
}

