import UIKit

final class ProjectEntryVC: UIViewController {
    private let projectNameLbl: UILabel = {
        let label = UILabel()
        label.text = "Название проекта"
        label.textColor = .systemTeal
        label.font = .boldSystemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let projectDescriptionLbl: UILabel = {
        let label = UILabel()
        label.text = "Описание проекта"
        label.textColor = .systemTeal
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let projectNameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let projectDescriptionField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите описание"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var saveButt: UIButton = {
        let butt = UIButton()
        butt.layer.cornerRadius = 20
        butt.backgroundColor = .systemTeal
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("Сохранить", for: .normal)
        butt.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return butt
    }()
    
    private var cancelButt: UIButton = {
        let butt = UIButton()
        butt.layer.cornerRadius = 20
        butt.backgroundColor = .systemTeal
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("Отмена", for: .normal)
        butt.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return butt
    }()
    
    lazy var cmndsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.clipsToBounds = true
        stack.contentMode = .scaleToFill
        stack.autoresizesSubviews = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(saveButt)
        stack.addArrangedSubview(cancelButt)
        return stack
    }()
    private var viewModel: ProjectListViewModel

     init(viewModel: ProjectListViewModel = ProjectListViewModel()) {
             self.viewModel = viewModel
             super.init(nibName: nil, bundle: .main)
         }
     required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    @objc func saveTapped() {
        let alertController = UIAlertController(title: "Данные сохранены", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
            self?.projectNameField.text = ""
            self?.projectDescriptionField.text = ""
        }))
        guard let projectName = projectNameField.text, let projectDescr = projectDescriptionField.text, !projectName.isEmpty, !projectDescr.isEmpty else { return }
        let newProject = ProjectCellModel(title: projectName, description: projectDescr)
        ProjectListViewModel.shared.saveProjects(data: newProject)
    //notificationCenter for the reload tableView data
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        self.present(alertController, animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpView()
        configureSubviews()
    }

    // Keyboard notification selectors
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y = -15
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0.0
    }
}

// MARK: - Setup
private extension ProjectEntryVC {
    func setUp() {
        projectNameField.delegate = self
        projectDescriptionField.delegate = self
        
    }
    func setUpView() {
        view.backgroundColor = .systemBackground
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        // Keyboard notification observers
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Layout
private extension ProjectEntryVC {
    func configureSubviews() {
        view.addSubview(projectNameLbl)
        view.addSubview(projectNameField)
        view.addSubview(projectDescriptionLbl)
        view.addSubview(projectDescriptionField)
        view.addSubview(cmndsStackView)
        
        NSLayoutConstraint.activate([
            //projectNameLbl Label
            projectNameLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            projectNameLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            projectNameLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            projectNameLbl.bottomAnchor.constraint(equalTo: projectNameField.topAnchor, constant: -20),
            //projectNameField TextField
            projectNameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            projectNameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            projectNameField.widthAnchor.constraint(equalToConstant: 80),
            projectNameField.heightAnchor.constraint(equalToConstant: 55),
            //projectDescriptionLbl Label
            projectDescriptionLbl.topAnchor.constraint(equalTo: projectNameField.bottomAnchor, constant: 30),
            projectDescriptionLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            projectDescriptionLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            projectDescriptionLbl.bottomAnchor.constraint(equalTo: projectDescriptionField.topAnchor, constant: -20),
            //projectDescriptionField TextField
            projectDescriptionField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            projectDescriptionField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            projectDescriptionField.widthAnchor.constraint(equalToConstant: 80),
            projectDescriptionField.heightAnchor.constraint(equalToConstant: 55),
            //cmndsStackView StackView
            cmndsStackView.topAnchor.constraint(equalTo: projectDescriptionField.bottomAnchor, constant: 50),
            cmndsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            cmndsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            cmndsStackView.widthAnchor.constraint(equalToConstant: 80),
            cmndsStackView.heightAnchor.constraint(equalToConstant: 60),
            
        ])
        
    }
}

//MARK: - UITextFieldDelegate
extension ProjectEntryVC: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveProject()
        return true
    }
    
    func saveProject() {
        guard let projectName = projectNameField.text, !projectName.isEmpty else { return }
    }
}
