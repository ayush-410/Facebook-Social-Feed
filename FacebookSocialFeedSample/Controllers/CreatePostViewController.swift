//
//  CreatePostViewController.swift
//  FacebookSocialFeedSample
//
//  Created by Ayush Kumar Singh on 21/09/23.
//

import UIKit
import YPImagePicker
import AVKit

protocol refreshFeedDataDelegate: AnyObject {
    func refreshFeedData()
}


class CreatePostViewController: UIViewController {
   
    
    @IBOutlet weak var postTxtView: UITextView!
    @IBOutlet weak var postCollectionView: UICollectionView!
    var selectedItems = [YPMediaItem]()
    var modelSocialFeed = socialFeedModel(id: "", title: "")
    weak var delegate: refreshFeedDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postCollectionView.isHidden = true
        postCollectionView.register(UINib(nibName: "SocialFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SocialFeedCollectionViewCell")
        
    }
    
    @IBAction func photoVideoBtnTapped(sender: UIButton) {
        showPicker()
    }
    
    @IBAction func btnDoneTapped(sender: UIBarButtonItem) {
        guard let postTitle = postTxtView.text else {
            return
        }
        modelSocialFeed.title = postTitle
        modelSocialFeed.id = "\(socialFeedDataModel.shared.arrSocialFeedModel.count + 1)"
        socialFeedDataModel.shared.arrSocialFeedModel.append(modelSocialFeed)
        delegate?.refreshFeedData()
        self.navigationController?.popViewController(animated: true)
    }
    
    func showPicker() {
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photoAndVideo
        config.library.itemOverlayType = .grid
        config.shouldSaveNewPicturesToAlbum = false
        config.video.compression = AVAssetExportPresetPassthrough
        config.startOnScreen = .library
        config.screens = [.library, .photo, .video]
        config.library.minWidthForItem = UIScreen.main.bounds.width * 0.8
        config.video.libraryTimeLimit = 500.0
        config.showsCrop = .rectangle(ratio: (16/9))
        config.wordings.libraryTitle = "Gallery"
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.maxCameraZoomFactor = 2.0
        config.library.maxNumberOfItems = 5
        config.gallery.hidesRemoveButton = false
        config.library.preselectedItems = selectedItems
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [weak picker] items, cancelled in
            if cancelled {
                print("Picker was canceled")
                picker?.dismiss(animated: true, completion: nil)
                return
            }
            _ = items.map { print("🧀 \($0)") }
            
            self.selectedItems = items
            self.modelSocialFeed.media = []
            for item in items {
                switch item {
                case .photo(let photo):
                    print(photo)
                    self.modelSocialFeed.media?.append(MediaModel(mediaType: .photo, thumbnail: photo.image, url: ""))
                case .video(let video):
                    print(video)
                    self.modelSocialFeed.media?.append(MediaModel(mediaType: .video, thumbnail: video.thumbnail, url: "\(video.url)"))
                }
            }
            picker?.dismiss(animated: true, completion: {
                self.postCollectionView.isHidden = false
                self.postCollectionView.reloadData()
            })
            
        }
        present(picker, animated: true, completion: nil)
    }
}
extension CreatePostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelSocialFeed.media?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialFeedCollectionViewCell", for: indexPath) as! SocialFeedCollectionViewCell
        cell.feedImage.image = modelSocialFeed.media?[indexPath.row].thumbnail
        return cell
    }
}

extension CreatePostViewController: UICollectionViewDelegateFlowLayout {
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

extension CreatePostViewController {
    static func sharedInstance() -> CreatePostViewController {
        return CreatePostViewController.instantiateFromStoryboard()
    }
}
