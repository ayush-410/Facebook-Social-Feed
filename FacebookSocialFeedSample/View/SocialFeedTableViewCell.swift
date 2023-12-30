//
//  SocialFeedTableViewCell.swift
//  FacebookSocialFeedSample
//
//  Created by Ayush Kumar Singh on 22/09/23.
//

import UIKit
import Lightbox

class SocialFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    
    var socialFeedData: socialFeedModel? {
        didSet{
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mediaCollectionView.register(UINib(nibName: "SocialFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SocialFeedCollectionViewCell")
    }
    
    
    
    @IBAction func btnCommentTapped(_ sender: Any) {
    }
    
    @IBAction func btnShareTapped(_ sender: Any) {
    }
    
    func updateUI() {
        lblName.text = socialFeedData?.title
        if let media = socialFeedData?.media, media.count > 0 {
            mediaCollectionView.isHidden = false
            mediaCollectionView.dataSource = self
            mediaCollectionView.delegate = self
        } else {
            mediaCollectionView.isHidden = true
        }
    }
    
    func getLightBoxImages() -> [LightboxImage] {
        var arrImage = [LightboxImage]()
        guard let media = socialFeedData?.media else {
            return arrImage
        }
        for image in media {
            let lightBoxImage = LightboxImage(image: image.thumbnail, text: "", videoURL: URL(string: image.url))
            arrImage.append(lightBoxImage)
        }
        return arrImage
    }
}

extension SocialFeedTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialFeedData?.media?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialFeedCollectionViewCell", for: indexPath) as! SocialFeedCollectionViewCell
        cell.feedImage.image = socialFeedData?.media?[indexPath.row].thumbnail
        return cell
    }
}

extension SocialFeedTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension SocialFeedTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = LightboxController(images: getLightBoxImages(), startIndex: indexPath.row)
        controller.modalPresentationStyle = .fullScreen
        UIApplication.getTopViewController()?.present(controller, animated: true)
    }
}
