import Foundation
import UIKit

 class ProjectTableViewCell: UITableViewCell {
    static let identifier = "projectCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "111111"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.contentMode = .scaleToFill
        label.sizeToFit()
        return label
    }()
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.font = UIFont.systemFont(ofSize: 18)
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        return label
    }()
    // Vertical Stack View
    lazy var vStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 3
        stack.distribution = .fill
        stack.setContentHuggingPriority(.required, for: .horizontal)
        
        stack.contentMode = .scaleToFill
        stack.autoresizesSubviews = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(descriptionLabel)
        return stack
    }()
    
    var viewModel: ProjectCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            descriptionLabel.text = viewModel?.description
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    func setupViews() {
        contentView.addSubview(vStackView)
        vStackView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        }
}
