//
//  Login_ViewController.swift
//  MasterCoreData
//
//  Created by Apple on 5/9/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookLogin

class Login_ViewController: UIViewController {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!
    let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
    @IBOutlet weak var loginFacebook: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.frame.size = CGSize(width: 100, height: 100)
        loader.startAnimating()
        if UserDefaults.standard.object(forKey: "logged") == nil {
            UserDefaults.standard.set(false, forKey: "logged")
            containerView.isHidden = true
        } else {
            containerView.isHidden = !UserDefaults.standard.bool(forKey: "logged")
        }
        getFBUserData()
//        DataService_getInfoUserFB.shared.getUserInfo()
    }
    
    @IBAction func loginFacebookBtn(_ sender: Any) {
        fbLogin()
    }
    
    func fbLogin() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(grantedPermissions: let grantedPermissions, declinedPermissions: let declinedPermissions, token: let accessToken):
                self.getFBUserData()
                print(grantedPermissions, declinedPermissions, accessToken)
            }
        }
    }
    
    func getFBUserData() {
        if FBSDKAccessToken.current() != nil {
            // lay gia tri (id: co the hien thi anh, name, email) cua fb sau khi login thanh cong
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: {
                (connect, result, err) in
                if err == nil {
                    // luu cac gia tri vao 1 Dictionary
                    guard let dict = result as? [String : AnyObject] else {return}
                    UserDefaults.standard.set(true, forKey: "logged")
                    print("Info \(dict)")
                    
                    self.performSegue(withIdentifier: "showContainerViewController", sender: nil)
                    
                    // lay cac gia tri de co the luu thong tin or hien thi
                    let name = dict["name"] as! String
                    let picture = dict["picture"] as! [String : AnyObject]
                    let data = picture["data"] as! [String : AnyObject]
                    let image = data["url"] as! String
                    let user = User(name: name, image: image)
                    
                    // ep gia tri vao 1 object
                    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
                    
                    // luu object vao userDefaults
                    UserDefaults.standard.set(encodedData, forKey: "user")
                    UserDefaults.standard.synchronize()
                }
            })
        } else {
            containerView.isHidden = true
        }
    }
}

