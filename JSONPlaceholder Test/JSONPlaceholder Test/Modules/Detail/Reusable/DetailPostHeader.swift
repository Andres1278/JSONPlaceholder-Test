//
//  DetailPostHeader.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 29/08/22.
//

import UIKit
import SkeletonView

class DetailPostHeader: UITableViewHeaderFooterView {
    
    // MARK: - Private properties -
    private lazy var titleLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.font = UIFont.systemFont(ofSize: 30)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.textColor = UIColor(named: "letterColor")
        infoLabel.isSkeletonable = true
        infoLabel.numberOfLines = .zero
        infoLabel.textAlignment = .left
        return infoLabel
    }()

    // MARK: - Lifecycle -
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    // MARK: - Private methods -
    private func setUpView() {
        isUserInteractionEnabled = false
        addSubViews()
        setUpConstraints()
    }
    
    private func addSubViews() {
        contentView.addSubview(titleLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Public methods -
    func configure(with title: String?) {
        guard let title = title else {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.titleLabel.showAnimatedGradientSkeleton()
            }
            return
        }
        titleLabel.hideSkeleton()
        titleLabel.stopSkeletonAnimation()
        titleLabel.text = title
    }
}

extension DetailPostHeader {
    static let reuseIdentifier = "DetailPostHeader"
}
