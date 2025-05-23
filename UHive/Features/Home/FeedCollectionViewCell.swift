//
//  FeedCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/24/25.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: FeedCollectionViewCellDelegate?
    
    static let reuseIdentifier: String = String(describing: FeedCollectionViewCell.self)
    
    var post: Post!
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postedTimeLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.roundCorners(radius: 20, corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        let tapGestureForLike = UITapGestureRecognizer(target: self, action: #selector(likePost))
        likeImageView.isUserInteractionEnabled = true
        likeImageView.addGestureRecognizer(tapGestureForLike)
        
        let tapGestureForComment = UITapGestureRecognizer(target: self, action: #selector(commentPost))
        commentImageView.isUserInteractionEnabled = true
        commentImageView.addGestureRecognizer(tapGestureForComment)
        commentLabel.isUserInteractionEnabled = true
        commentLabel.addGestureRecognizer(tapGestureForComment)
        
        let tapGestureForPost = UITapGestureRecognizer(target: self, action: #selector(viewPost))
        postLabel.isUserInteractionEnabled = true
        postLabel.addGestureRecognizer(tapGestureForPost)
    }
    
    func configure(with post: Post) {
        self.post = post
        nameLabel.text = post.user.name
        userNameLabel.text = "@\(post.user.name.lowercased().replacingOccurrences(of: " ", with: ""))"
        postedTimeLabel.text = post.createdAt.timeAgoSinceISODate()
        postLabel.text = post.content
        
        let cachedProfile = ProfileResponse.loadFromCache()
        if containsID(in: post.likes, targetID: cachedProfile?.id) {
            likeImageView.image = UIImage(systemName: "hand.thumbsup.fill")
        } else {
            likeImageView.image = UIImage(systemName: "hand.thumbsup")
        }
        if post.likes.count > 0 {
            likeLabel.text = "\(post.likes.count)"
        } else {
            likeLabel.text = "Like"
        }
    }
    
    func containsID<T: Equatable>(in array: [T], targetID: T) -> Bool {
        return array.contains(targetID)
    }

    
    @objc func likePost() {
        self.delegate?.didTapLikeButton(in: self)
    }
    
    @objc func commentPost() {
        self.delegate?.didTapCommentButton(in: self)
    }
    
    @objc func viewPost() {
        self.delegate?.didTapPostLabel(in: self)
    }
}

protocol FeedCollectionViewCellDelegate: AnyObject {
    func didTapLikeButton(in cell: FeedCollectionViewCell)
    func didTapCommentButton(in cell: FeedCollectionViewCell)
    func didTapPostLabel(in cell: FeedCollectionViewCell)
}
