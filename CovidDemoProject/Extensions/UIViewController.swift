//
//  UIViewController.swift
//  CovidDemoProject
//
//  Created by Amit Gupta on 17/03/24.
//

import UIKit

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    enum AppStoryboard: String {
        case Main
        
        var instance: UIStoryboard {
            return UIStoryboard(name: rawValue, bundle: Bundle.main)
        }
        
        func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
            let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
            return instance.instantiateViewController(withIdentifier: storyboardID) as! T
        }
        
        func initialViewController() -> UIViewController? {
            return instance.instantiateInitialViewController()
        }
    }
    
    func showAlertWith(message: String, title: String = "", completion: ((UIAlertAction) -> Void)? =  nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: completion)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
}
