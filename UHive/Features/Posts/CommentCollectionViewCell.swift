//
//  CommentCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 5/4/25.
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: CommentCollectionViewCell.self)

    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentContainerView.roundCorners(radius: 16, corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    func configure(with comment: PostByIdComment) {
        self.authorNameLabel.text = comment.user.name
        self.commentLabel.text = comment.content
        self.timeAgoLabel.text = comment.createdAt.timeAgoSinceISODate()
    }

}
