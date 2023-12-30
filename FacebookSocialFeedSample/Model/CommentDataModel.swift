//
//  CommentDataModel.swift
//  FacebookSocialFeedSample
//
//  Created by Ayush Kumar Singh on 23/09/23.
//

import Foundation

struct commentModel {
    var socialFeedID: String
    var commentID: String
    var title: String
}

class commentDataModel {
    static let shared = commentDataModel()
    private init(){}
    var arrCommentModel = [commentModel]()
}
