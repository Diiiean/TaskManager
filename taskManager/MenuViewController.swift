import UIKit

class MenuViewController: UIViewController {

    private var projectsButt: UIButton = {
        let butt = UIButton()
        butt.backgroundColor = .systemTeal
        butt.layer.cornerRadius = 20
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("ПРОЕКТЫ", for: .normal)
        butt.addTarget(MenuViewController.self, action: #selector(projectsTapped), for: .touchUpInside)
        return butt
    }()
    
    private var employeesButt: UIButton = {
        let butt = UIButton()
        butt.backgroundColor = .systemTeal
        butt.layer.cornerRadius = 20
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("РАБОТНИКИ", for: .normal)
        butt.addTarget(MenuViewController.self, action: #selector(employeesTapped), for: .touchUpInside)
        return butt
    }()
    
    private var tasksButt: UIButton = {
        let butt = UIButton()
        butt.backgroundColor = .systemTeal
        butt.layer.cornerRadius = 20
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("ЗАДАЧИ", for: .normal)
        butt.addTarget(MenuViewController.self, action: #selector(tasksTapped), for: .touchUpInside)
        return butt
    }()
    
    private var settingsButt: UIButton = {
        let butt = UIButton()
        butt.backgroundColor = .systemTeal
        butt.layer.cornerRadius = 20
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("НАСТРОЙКИ", for: .normal)
        butt.addTarget(MenuViewController.self, action: #selector(settingsTapped), for: .touchUpInside)
        return butt
    }()
    
    @objc func projectsTapped() {
//        let projectsVC = ProjectsListVC()
//        projectsVC.title = "Список проектов"
//        navigationController?.pushViewController(projectsVC, animated: true)
    }
    @objc func employeesTapped() {
//        let employeesVC = EmployeesListVC()
//        employeesVC.title = "Список работников"
//        navigationController?.pushViewController(employeesVC, animated: true)
    }
    @objc func tasksTapped() {
        print("tasksTapped")
    }
    @objc func settingsTapped() {
//        let settingsVC = SettingsVC()
//        settingsVC.title = "Настройки"
//        navigationController?.pushViewController(settingsVC, animated: true)
    }
    lazy var vStackView: UIStackView = {
            let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.alignment = .fill
            stack.spacing = 40
        stack.distribution = .fillEqually
            stack.clipsToBounds = true
            stack.backgroundColor = .systemTeal
            stack.addArrangedSubview(projectsButt)
            stack.addArrangedSubview(tasksButt)
            stack.addArrangedSubview(employeesButt)
            stack.addArrangedSubview(settingsButt)
            return stack
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
       //configureStack()
        configureButtons()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    func setUpView() {
        view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    func configureStack() {
        view.addSubview(vStackView)
        //Constraints
        setStackViewConstraints()
    }
    func setStackViewConstraints() {
        vStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 170, left: 50, bottom: -200 , right: -50))
    }
    func configureButtons() {
        view.addSubview(projectsButt)
        view.addSubview(employeesButt)
        view.addSubview(tasksButt)
        view.addSubview(settingsButt)
        NSLayoutConstraint.activate([
            //Projects Butt
           projectsButt.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180),
            projectsButt.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            projectsButt.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            projectsButt.bottomAnchor.constraint(equalTo: employeesButt.topAnchor, constant: -20),
            projectsButt.widthAnchor.constraint(equalTo: employeesButt.widthAnchor),
            projectsButt.heightAnchor.constraint(equalTo:employeesButt.heightAnchor),
            //Employees Butt
            employeesButt.topAnchor.constraint(equalTo: projectsButt.bottomAnchor, constant: 20),
            employeesButt.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            employeesButt.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            employeesButt.bottomAnchor.constraint(equalTo: tasksButt.topAnchor, constant: -20),
            employeesButt.widthAnchor.constraint(equalToConstant: 100),
            employeesButt.heightAnchor.constraint(equalToConstant: 70),
            //Tasks Butt
            tasksButt.topAnchor.constraint(equalTo: employeesButt.bottomAnchor, constant: 20),
            tasksButt.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            tasksButt.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            tasksButt.bottomAnchor.constraint(equalTo: settingsButt.topAnchor, constant: -20),
            tasksButt.widthAnchor.constraint(equalTo: employeesButt.widthAnchor),
            tasksButt.heightAnchor.constraint(equalTo:employeesButt.heightAnchor),
            //Settings Butt
            settingsButt.topAnchor.constraint(equalTo: tasksButt.bottomAnchor, constant: 20),
            settingsButt.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            settingsButt.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            settingsButt.widthAnchor.constraint(equalTo: employeesButt.widthAnchor),
            settingsButt.heightAnchor.constraint(equalTo:employeesButt.heightAnchor),
        ])
    }
//    func configureStackView() {
//        view.addSubview(stackView)
//        //Constraints
//        setStackViewConstraints()
//    }
//    func setStackViewConstraints() {
//        stackView.translatesAutoresizingMaskIntoConstraints                                                          = false
//        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive           = true
//        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive   = true
//        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive    = true
//    }
}

