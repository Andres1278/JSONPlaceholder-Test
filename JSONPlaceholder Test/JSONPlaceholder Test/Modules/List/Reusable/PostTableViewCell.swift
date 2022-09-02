//
//  PostTableViewCell.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 26/08/22.
//

import UIKit
import SkeletonView

struct PostCellViewModel {
    let title: String
    
    init(title: String) {
        self.title = title
    }
}

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Private properties -
    private lazy var containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.backgroundColor = .clear
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .blue
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(named: "letterColor")
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var titleSkeletonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.isSkeletonable = true
        return view
    }()
    
    // MARK: - Lifecycle -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        setUpConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    // MARK: - Private methods -
    private func addViews() {
        containerStackView.addArrangedSubview(titleLabel)
        contentView.addSubview(containerStackView)
        contentView.addSubview(titleSkeletonView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleSkeletonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleSkeletonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleSkeletonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleSkeletonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
        
    // MARK: - Public methods -
    func setData(_ data: PostCellViewModel?) {
        guard let model = data else {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.titleSkeletonView.isHidden = false
                strongSelf.titleSkeletonView.showAnimatedGradientSkeleton()
                strongSelf.isUserInteractionEnabled = false
            }
            return
        }
        titleSkeletonView.isHidden = true
        titleSkeletonView.hideSkeleton()
        titleSkeletonView.stopSkeletonAnimation()
        isUserInteractionEnabled = true
        titleLabel.text = model.title
    }
}

extension PostTableViewCell {
    static let reuseIdentifier = "PostTableViewCell"
}
