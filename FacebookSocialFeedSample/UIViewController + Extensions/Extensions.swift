//
//  Extensions.swift
//  FacebookSocialFeedSample
//
//  Created by Ayush Kumar Singh on 22/09/23.
//

import UIKit

extension UIViewController {
    
    class func instantiateFromStoryboard(_ name: String = "Main") -> Self {
        return instantiateFromStoryboardHelper(name)
    }
    
   fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "\(Self.self)") as! T
        return controller
    }
    
    func showAlert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}
