import UIKit

class SplashScreen: UIViewController {
    var menuScreen = MenuViewController()
    
    private var projectNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Управление Задачами"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Версия: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .center
            stack.spacing = 20
            stack.distribution = .fillEqually
            stack.clipsToBounds = true
            stack.translatesAutoresizingMaskIntoConstraints                                                          = false
            stack.addArrangedSubview(projectNameLabel)
            stack.addArrangedSubview(versionLabel)
            return stack
        }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureStackView()
        view.backgroundColor = .systemBackground
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.menuScreen.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(self.menuScreen, animated: false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        //Constraints
        setStackViewConstraints()
    }
    
    func setStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
      
    }
}
