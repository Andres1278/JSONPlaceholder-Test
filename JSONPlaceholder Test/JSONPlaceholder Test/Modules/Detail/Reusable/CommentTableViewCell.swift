//
//  CommentTableViewCell.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 28/08/22.
//

import UIKit
import SkeletonView

struct CommentCellViewModel {
    let body: String
    let email: String
    
    init(body: String, email: String) {
        self.body = body
        self.email = email
    }
}

class CommentTableViewCell: UITableViewCell {

    // MARK: - IBOutlets -
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var skeletonView: UIView!
    @IBOutlet private weak var byLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    // MARK: - LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        commentLabel.text = nil
        emailLabel.text = nil
    }
    
    // MARK: - Private methods -
    func setupView() {
        isUserInteractionEnabled = false
        skeletonView.isSkeletonable = true
        skeletonView.skeletonCornerRadius = 8
        commentLabel.font = UIFont.systemFont(ofSize: 18)
        commentLabel.textColor = UIColor(named: "letterColor")
        commentLabel.numberOfLines = 0
        byLabel.font = UIFont.systemFont(ofSize: 8)
        byLabel.textColor = .gray
        byLabel.text = "By: "
        byLabel.isHidden = true
        emailLabel.font = UIFont.systemFont(ofSize: 10)
        emailLabel.textColor = UIColor(named: "letterColor")
    }
    
    // MARK: - Public methods -
    func configure(with model: CommentCellViewModel?) {
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
        commentLabel.stopSkeletonAnimation()
        commentLabel.hideSkeleton()
        byLabel.isHidden = false
        commentLabel.text = model.body
        emailLabel.text = model.email
    }
    
}

extension CommentTableViewCell {
    static let reuseIdentifier = "CommentTableViewCell"
}
