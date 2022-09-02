//
//  PostInfoTableViewCell.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 29/08/22.
//

import UIKit

struct PostDetailCellViewModel {
    let body: String
    let title: String
    
    init(body: String, title: String) {
        self.body = body
        self.title = title
    }
}

class PostInfoTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var descriptionTitleLabel: UILabel!
    @IBOutlet private weak var skeletonView: UIView!
    @IBOutlet private weak var descriptionBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postTitleLabel.text = nil
        descriptionBodyLabel.text = nil
    }
    
    // MARK: - Private methods -
    private func setupView() {
        isUserInteractionEnabled = false
        skeletonView.isSkeletonable = true
        skeletonView.skeletonCornerRadius = 8
        descriptionTitleLabel.text = "Description: "
        descriptionTitleLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionTitleLabel.textColor = .lightGray
        postTitleLabel.font = UIFont.systemFont(ofSize: 22)
        postTitleLabel.textColor = UIColor(named: "letterColor")
        postTitleLabel.numberOfLines = 0
        postTitleLabel.textAlignment = .center
        descriptionBodyLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionBodyLabel.textColor = UIColor(named: "letterColor")
        descriptionBodyLabel.numberOfLines = 0
    }
    
    // MARK: - Public methods -
    func configure(with model: PostDetailCellViewModel?) {
        guard let model = model else {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.skeletonView.isHidden = false
                strongSelf.skeletonView.showAnimatedGradientSkeleton()
            }
            return
        }
        skeletonView.isHidden = true
        skeletonView.stopSkeletonAnimation()
        skeletonView.hideSkeleton()
        postTitleLabel.text = model.title.capitalized
        descriptionBodyLabel.text = model.body
    }
    
}

extension PostInfoTableViewCell {
    static let reuseIdentifier = "PostInfoTableViewCell"
}
