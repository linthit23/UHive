//
//  HomeViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/23/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var posts: [Post] = []
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var featureCollectionView: UICollectionView!
    @IBOutlet weak var feedCollectionView: UICollectionView!
    @IBOutlet weak var boxHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var postingLabelView: UIView!
    @IBOutlet weak var postingLabel: UILabel!
    @IBOutlet weak var postingHeightConstraint: NSLayoutConstraint!
    
    private var lastContentOffset: CGFloat = 0
    private let originalBoxHeight: CGFloat = 128
    private var originalProfileHeight: CGFloat = 60
    private var originalPostingHeight: CGFloat = 60
    
    private var blurEffectView: UIVisualEffectView!
    private var postContainerView: UIView!
    private var postTextView: UITextView!
    private var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featureCollectionView.delegate = self
        featureCollectionView.dataSource = self
        featureCollectionView.register(UINib(nibName: FeatureCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FeatureCollectionViewCell.reuseIdentifier)
        
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        feedCollectionView.register(UINib(nibName: FeedCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FeedCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
        setupPostUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openProfile))
        profileView.isUserInteractionEnabled = true
        profileView.addGestureRecognizer(tapGesture)
        
        let tapGestureForPosting = UITapGestureRecognizer(target: self, action: #selector(openPosting))
        postingLabel.isUserInteractionEnabled = true
        postingLabel.addGestureRecognizer(tapGestureForPosting)
        postingLabelView.isUserInteractionEnabled = true
        postingLabelView.addGestureRecognizer(tapGestureForPosting)
        
        fetchPosts()
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profileView.roundCorners(radius: 30, corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        postingLabelView.roundCorners(radius: 30, corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let layout = featureCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        if let layout = feedCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        
    }
    
    private func style() {}
    
    @objc func openProfile() {
        let profileVC = ProfileViewController()
        profileVC.modalPresentationStyle = .pageSheet
        profileVC.isModalInPresentation = true
        self.present(profileVC, animated: true)
    }
    
    private func setupPostUI() {
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0
        view.addSubview(blurEffectView)
        
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissPostUI))
        blurEffectView.addGestureRecognizer(dismissTap)
        
        postContainerView = UIView()
        postContainerView.backgroundColor = .white
        postContainerView.layer.cornerRadius = 16
        postContainerView.translatesAutoresizingMaskIntoConstraints = false
        postContainerView.alpha = 0
        view.addSubview(postContainerView)
        
        postTextView = UITextView()
        postTextView.font = UIFont.systemFont(ofSize: 16)
        postTextView.layer.borderWidth = 1
        postTextView.layer.borderColor = UIColor.gray.cgColor
        postTextView.layer.cornerRadius = 8
        postTextView.translatesAutoresizingMaskIntoConstraints = false
        postContainerView.addSubview(postTextView)
        
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Post", for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 8
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(submitPost), for: .touchUpInside)
        postContainerView.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            postContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            postContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            postContainerView.heightAnchor.constraint(equalToConstant: 200),
            
            postTextView.topAnchor.constraint(equalTo: postContainerView.topAnchor, constant: 16),
            postTextView.leadingAnchor.constraint(equalTo: postContainerView.leadingAnchor, constant: 16),
            postTextView.trailingAnchor.constraint(equalTo: postContainerView.trailingAnchor, constant: -16),
            postTextView.heightAnchor.constraint(equalToConstant: 100),
            
            submitButton.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 12),
            submitButton.leadingAnchor.constraint(equalTo: postTextView.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: postTextView.trailingAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    
    @objc func openPosting() {
        submitButton.setTitle("Post", for: .normal)
        submitButton.isEnabled = true
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 1
            self.postContainerView.alpha = 1
        }
    }
    
    @objc func submitPost() {
        guard let text = postTextView.text, !text.isEmpty else { return }
        submitButton.setTitle("Posting...", for: .normal)
        submitButton.isEnabled = false
        uploadPost(text)
    }
    
    @objc func dismissPostUI() {
        postTextView.resignFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 0
            self.postContainerView.alpha = 0
        }
    }
    
    func openFeature(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let newsVC = NewsViewController()
            newsVC.modalPresentationStyle = .pageSheet
            newsVC.isModalInPresentation = true
            let newsNav = UINavigationController(rootViewController: newsVC)
            newsNav.navigationBar.tintColor = .black
            self.present(newsNav, animated: true)
        case 1:
            let bookingsVC = BookingsViewController()
            bookingsVC.modalPresentationStyle = .pageSheet
            bookingsVC.isModalInPresentation = true
            let bookingsNav = UINavigationController(rootViewController: bookingsVC)
            bookingsNav.navigationBar.tintColor = .black
            self.present(bookingsNav, animated: true)
        case 2:
            let paymentsVC = PaymentsViewController()
            paymentsVC.modalPresentationStyle = .pageSheet
            paymentsVC.isModalInPresentation = true
            let paymentsNav = UINavigationController(rootViewController: paymentsVC)
            paymentsNav.navigationBar.tintColor = .black
            self.present(paymentsNav, animated: true)
        default: break
        }
    }
    
    func fetchPosts() {
        PostsService().fetchAllPosts { [weak self] postsResponse in
            guard let self = self, let posts = postsResponse?.data else {
                print("Failed to load posts")
                return }
            self.posts = posts
            
            DispatchQueue.main.async {
                self.feedCollectionView.reloadData()
            }
        }
    }
    
    func uploadPost(_ content: String) {
        PostsService().posting(content: content) { [weak self] post in
            guard let self = self, let _ = post else {
                print("Failed to post")
                return
            }
            postTextView.resignFirstResponder()
            UIView.animate(withDuration: 0.3) {
                self.blurEffectView.alpha = 0
                self.postContainerView.alpha = 0
            }
            postTextView.text = ""
            fetchPosts()
        }
    }
    
    func openPost(_ post: Post, isComment: Bool) {
        let postVC = PostViewController()
        postVC.isComment = isComment
        postVC.post = post
        postVC.modalPresentationStyle = .pageSheet
        postVC.isModalInPresentation = true
        postVC.onUpdate = { [weak self] in
            self?.fetchPosts()
        }
        let postNav = UINavigationController(rootViewController: postVC)
        postNav.navigationBar.tintColor = .black
        self.present(postNav, animated: true)
    }
    
    func likeOnPost(_ cell: FeedCollectionViewCell) {
        PostsService().likeOnPost(id: cell.post.id) { [weak self] post in
            guard let _ = self, let _ = post else {
                print("Failed to load posts")
                return
            }
            DispatchQueue.main.async {
                let transformedPost = Post(id: post!.id, content: post!.content, user: cell.post.user, likes: post!.likes, comments: post!.comments, createdAt: cell.post.createdAt, updatedAt: cell.post.updatedAt)
                cell.configure(with: transformedPost)
                if let index = self?.posts.firstIndex(where: { $0.id == cell.post.id }) {
                    self?.posts[index] = transformedPost
                }
            }
        }
    }
    
    func unlikeOnPost(_ cell: FeedCollectionViewCell) {
        PostsService().unlikeOnPost(id: cell.post.id) { [weak self] post in
            guard let _ = self, let _ = post else {
                print("Failed to load posts")
                return
            }
            DispatchQueue.main.async {
                let transformedPost = Post(id: post!.id, content: post!.content, user: cell.post.user, likes: post!.likes, comments: post!.comments, createdAt: cell.post.createdAt, updatedAt: cell.post.updatedAt)
                cell.configure(with: transformedPost)
                if let index = self?.posts.firstIndex(where: { $0.id == cell.post.id }) {
                    self?.posts[index] = transformedPost
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == featureCollectionView {
            openFeature(indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featureCollectionView {
            return 3
        } else if collectionView == feedCollectionView {
            return posts.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featureCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCollectionViewCell.reuseIdentifier, for: indexPath) as? FeatureCollectionViewCell else {
                return UICollectionViewCell()
            }
            switch indexPath.row {
            case 0:
                cell.iconImageView.image = UIImage(systemName: "newspaper")
                cell.titleLabel.text = "News"
            case 1:
                cell.iconImageView.image = UIImage(systemName: "bookmark")
                cell.titleLabel.text = "Bookings"
            case 2:
                cell.iconImageView.image = UIImage(systemName: "creditcard")
                cell.titleLabel.text = "Payments"
            default:
                cell.backgroundColor = .white
            }
            return cell
        } else if collectionView == feedCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.reuseIdentifier, for: indexPath) as? FeedCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            let post = posts[indexPath.item]
            cell.configure(with: post)
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - Layout Configuration
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == featureCollectionView {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == featureCollectionView ? 10 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == featureCollectionView ? 10 : 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == featureCollectionView {
            let padding: CGFloat = 16
            let spacing: CGFloat = 10
            let itemsPerRow: CGFloat = 3
            
            let totalSpacing = (2 * padding) + ((itemsPerRow - 1) * spacing)
            let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
            return CGSize(width: itemWidth, height: 120)
        } else if collectionView == feedCollectionView {
            return CGSize(width: collectionView.frame.width, height: 220)
        }
        return CGSize.zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if posts.count > 5 {
            guard scrollView == feedCollectionView else { return }
            
            let currentOffset = scrollView.contentOffset.y
            
            if currentOffset > lastContentOffset {
                // Scrolling up — collapse
                if boxHeightConstraint.constant != 0 {
                    boxHeightConstraint.constant = 0
                    profileHeightConstraint.constant = 0
                    postingHeightConstraint.constant = 0
                    UIView.animate(withDuration: 0.4) {
                        self.view.layoutIfNeeded()
                    }
                }
            } else if currentOffset < lastContentOffset {
                // Scrolling down — expand
                if boxHeightConstraint.constant == 0 {
                    boxHeightConstraint.constant = originalBoxHeight
                    profileHeightConstraint.constant = originalProfileHeight
                    postingHeightConstraint.constant = originalPostingHeight
                    UIView.animate(withDuration: 0.4) {
                        self.view.layoutIfNeeded()
                    }
                }
            }
            
            lastContentOffset = currentOffset
        }
    }

    
}

extension HomeViewController: FeedCollectionViewCellDelegate {
    
    func didTapLikeButton(in cell: FeedCollectionViewCell) {
        if cell.likeImageView.image == UIImage(systemName: "hand.thumbsup") {
            likeOnPost(cell)
        } else if cell.likeImageView.image == UIImage(systemName: "hand.thumbsup.fill") {
            unlikeOnPost(cell)
        }
    }
    
    func didTapCommentButton(in cell: FeedCollectionViewCell) {
        openPost(cell.post, isComment: true)
    }
    
    func didTapPostLabel(in cell: FeedCollectionViewCell) {
        openPost(cell.post, isComment: false)
    }
}
