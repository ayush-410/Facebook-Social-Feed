//
//  SocialFeedViewController.swift
//  FacebookSocialFeedSample
//
//  Created by Ayush Kumar Singh on 22/09/23.
//

import UIKit

class SocialFeedViewController: UIViewController {
    @IBOutlet weak var socialFeedTableView: UITableView!
    var arrSocialFeed = [socialFeedModel]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        socialFeedTableView.register(UINib(nibName: "SocialFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "SocialFeedTableViewCell")
    }
    
    @IBAction func btnAddPostTapped(_ sender: UIBarButtonItem) {
        let createPostVC = CreatePostViewController.sharedInstance()
        createPostVC.delegate = self
        self.navigationController?.pushViewController(createPostVC, animated: true)
    }
    @objc func btnLikeTapped(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                sender.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            } completion: { finished in
                sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
    
    @objc func btnCommentTapped(sender: UIButton) {
        let commentVC = CommentViewController.sharedInstance()
        commentVC.modelSocialFeed = socialFeedDataModel.shared.arrSocialFeedModel[sender.tag]
        self.navigationController?.pushViewController(commentVC, animated: true)
    }
}

extension SocialFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socialFeedDataModel.shared.arrSocialFeedModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialFeedTableViewCell", for: indexPath) as! SocialFeedTableViewCell
        cell.socialFeedData = socialFeedDataModel.shared.arrSocialFeedModel[indexPath.row]
        print(cell.socialFeedData as Any)
        cell.btnLike.tag = indexPath.row
        cell.btnLike.addTarget(self, action: #selector(btnLikeTapped(sender:)), for: .touchUpInside)
        cell.btnComment.tag = indexPath.row
        cell.btnComment.addTarget(self, action: #selector(btnCommentTapped(sender:)), for: .touchUpInside)
        return cell
    }
}

extension SocialFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension SocialFeedViewController: refreshFeedDataDelegate {
    func refreshFeedData() {
        socialFeedTableView.reloadData()
    }
    
    
}


    
    
