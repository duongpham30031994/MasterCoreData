//
//  ContainerViewController.swift
//  MasterCoreData
//
//  Created by Apple on 5/9/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var sideMenuViewContainer: UIView!
    @IBOutlet weak var mainViewContainer: UIView!
    @IBOutlet weak var leftSideMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var corverButton: UIButton!
    
    static var instance: ContainerViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
    }
    
    var isSideMenuOpen: Bool = true {
        didSet {
            if isSideMenuOpen {
                
                configForSideMenuOpeningState()
            } else {
                configForSideMenuClosingState()
            }
            UIView.animate(withDuration: 0.35, animations: {
                self.view.layoutIfNeeded()
                
            }) { (isSuccess) in
                if self.isSideMenuOpen {
                    
                } else {
                    self.sideMenuViewContainer.clipsToBounds = true
                }
            }
        }
    }
    
    func configForSideMenuOpeningState() {
        self.sideMenuViewContainer.clipsToBounds = false
        self.leftSideMenuConstraint.constant = 0
        self.corverButton.alpha = 0.5
    }

    // menu will hide when click to space.
    
    func configForSideMenuClosingState() {
        self.leftSideMenuConstraint.constant = -self.sideMenuViewContainer.bounds.width
        self.corverButton.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotification()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(onClickCorverButton), name: NotificationKey.menuClick, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Set button turn on, off
    @IBAction func onClickCorverButton() {
        isSideMenuOpen = !isSideMenuOpen
    }
}
