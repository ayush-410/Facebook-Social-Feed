//
//  SocialFeedModel.swift
//  FacebookSocialFeedSample
//
//  Created by Ayush Kumar Singh on 21/09/23.
//

import Foundation
import UIKit

struct socialFeedModel {
    var id: String
    var title: String
    var media: [MediaModel]?
}

struct MediaModel {
    let mediaType: MediaType
    let thumbnail: UIImage
    let url: String
}
enum MediaType {
    case photo
    case video
}

class socialFeedDataModel {
    static let shared = socialFeedDataModel()
    private init(){}
    var arrSocialFeedModel = [socialFeedModel]()
}
