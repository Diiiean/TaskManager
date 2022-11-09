import UIKit

class SettingsVC: UIViewController {
    private let urlLabel: UILabel = {
        let label = UILabel()
        label.text = "URL сервера"
        label.textColor = .systemTeal
        label.font = .boldSystemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let recordsCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Максимальное количество записей"
        label.textColor = .systemTeal
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let daysIntervalLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество дней по умолчанию между начальной и конечной датами в задаче"
        label.textColor = .systemTeal
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let urlTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите URL сервера"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let recordsCountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите количество записей"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .asciiCapableNumberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let daysIntervalTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите количество дней"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .asciiCapableNumberPad
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
    
    @objc func saveTapped() {
        let alertController = UIAlertController(title: "Данные сохранены", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
            self?.urlTextField.text = ""
            self?.recordsCountTextField.text = ""
            self?.daysIntervalTextField.text = ""
            self?.navigationController?.popViewController(animated: true)
        }))
        self.present(alertController, animated: true)
    }
    
    @objc func cancelTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpView()
        setupTextFields()
        configureSubviews()
    }
    func setUp() {
        urlTextField.delegate = self
        recordsCountTextField.delegate = self
        daysIntervalTextField.delegate = self
        
    }
    func setUpView() {
        view.backgroundColor = .systemBackground
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        // Keyboard notification observers
          NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

          NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func configureSubviews() {
        view.addSubview(urlLabel)
        view.addSubview(urlTextField)
        view.addSubview(recordsCountLabel)
        view.addSubview(recordsCountTextField)
        view.addSubview(daysIntervalLabel)
        view.addSubview(daysIntervalTextField)
        view.addSubview(cmndsStackView)
        
        NSLayoutConstraint.activate([
            //URL Label
            urlLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            urlLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            urlLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            urlLabel.bottomAnchor.constraint(equalTo: urlTextField.topAnchor, constant: -20),
            //URL TextField
            urlTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            urlTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            //urlLabel.bottomAnchor.constraint(equalTo: recordsCountLabel.topAnchor, constant: -30),
            urlTextField.widthAnchor.constraint(equalToConstant: 80),
            urlTextField.heightAnchor.constraint(equalToConstant: 55),
            //RecordsCountLabel Label
            recordsCountLabel.topAnchor.constraint(equalTo: urlTextField.bottomAnchor, constant: 30),
            recordsCountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            recordsCountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            recordsCountLabel.bottomAnchor.constraint(equalTo: recordsCountTextField.topAnchor, constant: -20),
            //RecordsCountTextField TextField
            recordsCountTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            recordsCountTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            recordsCountTextField.widthAnchor.constraint(equalToConstant: 80),
            recordsCountTextField.heightAnchor.constraint(equalToConstant: 55),
            //NumOfDaysLabel Label
            daysIntervalLabel.topAnchor.constraint(equalTo: recordsCountTextField.bottomAnchor, constant: 30),
            daysIntervalLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            daysIntervalLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            daysIntervalLabel.bottomAnchor.constraint(equalTo: daysIntervalTextField.topAnchor, constant: -20),
            //DaysCountTextField TextField
            daysIntervalTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            daysIntervalTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            daysIntervalTextField.widthAnchor.constraint(equalToConstant: 80),
            daysIntervalTextField.heightAnchor.constraint(equalToConstant: 55),
            //cmndsStackView StackView
            cmndsStackView.topAnchor.constraint(equalTo: daysIntervalTextField.bottomAnchor, constant: 50),
            cmndsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            cmndsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            cmndsStackView.widthAnchor.constraint(equalToConstant: 80),
            cmndsStackView.heightAnchor.constraint(equalToConstant: 60),
            
        ])
        
    }
//    func setUpNotificationCenter() {
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
//            self.view.frame.origin.y = -200
//        }
//        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
//            self.view.frame.origin.y = 0.0
//        }
//    }
    func setupTextFields() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Готово", style: .done,
                                         target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        recordsCountTextField.inputAccessoryView = toolbar
        daysIntervalTextField.inputAccessoryView = toolbar
    }
    
    // Button selectors
    @objc func doneButtonTapped() {
        UserDefaults.standard.set(recordsCountTextField.text, forKey: "recordsCount")
        print(UserDefaults.standard.value(forKey: "recordsCount"))
        
        UserDefaults.standard.set(daysIntervalTextField.text, forKey: "daysInterval")
        print(UserDefaults.standard.value(forKey: "daysInterval"))
        
        view.endEditing(true)
    }
    // Keyboard notification selectors
    @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y = -30
            }
        }

        @objc func keyboardWillHide(notification: NSNotification) {
            self.view.frame.origin.y = 0.0
        }
}
//MARK: - UITextFieldDelegate
extension SettingsVC: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == urlTextField {
            UserDefaults.standard.set(urlTextField.text, forKey: "serverURL")
            print(UserDefaults.standard.value(forKey: "serverURL"))
            self.urlTextField.resignFirstResponder()
            
        }
        if textField == recordsCountTextField {
            UserDefaults.standard.set(recordsCountTextField.text, forKey: "recordsCount")
            print(UserDefaults.standard.value(forKey: "recordsCount"))
            self.recordsCountTextField.resignFirstResponder()
        }
        if textField == daysIntervalTextField {
            self.daysIntervalTextField.resignFirstResponder()
        }
        return true
    }
}
