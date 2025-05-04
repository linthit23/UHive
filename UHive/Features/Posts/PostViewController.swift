//
//  PostViewController.swift
//  UHive
//
//  Created by Lin Thit on 5/4/25.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: Post!
    var postById: PostByIdResponse?
    var isComment: Bool!
    var nameForPost: String!
    var onUpdate: (() -> Void)?
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentContainerView: UIView!
    @IBOutlet weak var commentContainerBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        
        postCollectionView.register(UINib(nibName: PostCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
        postCollectionView.register(UINib(nibName: CommentCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CommentCollectionViewCell.reuseIdentifier)
        
        postCollectionView.register(UICollectionReusableView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: "DefaultHeader")
        
        commentTextField.delegate = self
        
        layout()
        style()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModalVC))
        closeImageView.isUserInteractionEnabled = true
        closeImageView.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        fetchPostById()
        
        if isComment {
            self.commentTextField.becomeFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let layout = postCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    private func style() {}
    
    @objc func dismissModalVC() {
        self.dismiss(animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.commentContainerBottomConstraint.constant = keyboardFrame.height-20
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.commentContainerBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func fetchPostById() {
        PostsService().fetchPostById(id: post.id) { [weak self] post in
            guard let self = self, let post = post else {
                print("Failed to load post")
                return
            }
            
            self.postById = post
            DispatchQueue.main.async {
                self.postCollectionView.reloadData()
            }
        }
    }
    
    func commentOnPost() {
        if commentTextField.text?.isEmpty == false {
            PostsService().commentOnPost(id: post.id, content: commentTextField.text!) { [weak self] post in
                guard let self = self, let _ = post else {
                    print("Failed to load post")
                    return
                }
                self.commentTextField.resignFirstResponder()
                self.commentTextField.text = ""
                fetchPostById()
                
            }

        }
    }
    
    func likeOnPost(_ cell: PostCollectionViewCell) {
        PostsService().likeOnPost(id: cell.id) { [weak self] post in
            guard let self = self, let post = post else {
                print("Failed to load post")
                return
            }
            cell.configure(with: postById!, post: .init(id: post.id, content: post.content, user: self.post.user, likes: post.likes, comments: post.comments, createdAt: postById!.createdAt, updatedAt: postById!.updatedAt))
            self.onUpdate?()
        }
    }
    
    func unlikeOnPost(_ cell: PostCollectionViewCell) {
        PostsService().unlikeOnPost(id: cell.id) { [weak self] post in
            guard let self = self, let post = post else {
                print("Failed to load post")
                return
            }
            cell.configure(with: postById!, post: .init(id: post.id, content: post.content, user: self.post.user, likes: post.likes, comments: post.comments, createdAt: postById!.createdAt, updatedAt: postById!.updatedAt))
            self.onUpdate?()
        }
    }
    
}

// MARK: - CollectionView

extension PostViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return postById?.comments.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseIdentifier, for: indexPath) as? PostCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            if let postById = self.postById {
                cell.configure(with: postById, post: self.post)
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCollectionViewCell.reuseIdentifier, for: indexPath) as? CommentCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let postById = self.postById {
                cell.configure(with: postById.comments[indexPath.item])
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "DefaultHeader",
                                                                         for: indexPath)
            header.subviews.forEach { $0.removeFromSuperview() }
            
            let label = UILabel(frame: CGRect(x: 16, y: 0, width: collectionView.frame.width - 32, height: 40))
            label.text = "Comments"
            label.font = .boldSystemFont(ofSize: 16)
            label.textColor = .label
            header.addSubview(label)
            
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 1 ? CGSize(width: collectionView.frame.width, height: 40) : .zero
    }
    
    // MARK: - Layout config
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return section == 1 ? UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0) : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width-32, height: 250)
        case 1:
            return CGSize(width: collectionView.frame.width-32, height: 70)
        default:
            return .zero
        }
    }
}

extension PostViewController: PostCollectionViewCellDelegate {
    func didTapLikeButton(in cell: PostCollectionViewCell) {
        if cell.likeImageView.image == UIImage(systemName: "hand.thumbsup") {
            likeOnPost(cell)
        } else if cell.likeImageView.image == UIImage(systemName: "hand.thumbsup.fill") {
            unlikeOnPost(cell)
        }
    }
    
    func didTapCommentButton(in cell: PostCollectionViewCell) {
        commentTextField.becomeFirstResponder()
    }

}

extension PostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        commentOnPost()
        return true
    }
}
