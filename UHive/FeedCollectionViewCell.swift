//
//  FeedCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/24/25.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: FeedCollectionViewCell.self)
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postedTimeLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
