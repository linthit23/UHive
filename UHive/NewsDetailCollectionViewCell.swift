//
//  NewsDetailCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/24/25.
//

import UIKit

class NewsDetailCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier: String = String(describing: NewsDetailCollectionViewCell.self)
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var announcedFromLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var announcedAtLabel: UILabel!
    @IBOutlet weak var announcedFigureImageView: UIImageView!
    @IBOutlet weak var decriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    private func style() {
        
    }

}
