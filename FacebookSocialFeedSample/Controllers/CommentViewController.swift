//
//  CommentViewController.swift
//  FacebookSocialFeedSample
//
//  Created by Ayush Kumar Singh on 23/09/23.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentTxt: UITextField!
    var modelSocialFeed: socialFeedModel?
    var arrComment = [commentModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        commentTxt.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrComment = commentDataModel.shared.arrCommentModel.filter{
            $0.socialFeedID == modelSocialFeed?.id
        }
    }
    
    
    @IBAction func btnSendTapped(_ sender: UIButton) {
        guard let feed = modelSocialFeed, let comment = commentTxt.text else {
            return
        }
        let commentData = commentModel(socialFeedID: feed.id, commentID: "\(commentDataModel.shared.arrCommentModel.count + 1)", title: comment)
        commentDataModel.shared.arrCommentModel.append(commentData)
        arrComment.append(commentData)
        commentTableView.reloadData()
        commentTxt.resignFirstResponder()
    }
    
}
extension CommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arrComment[indexPath.row].title
        return cell
    }
    
    
}

extension CommentViewController {
    static func sharedInstance() -> CommentViewController {
        return CommentViewController.instantiateFromStoryboard()
    }
}
