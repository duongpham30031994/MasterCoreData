//
//  ShowTableViewController.swift
//  MasterCoreData
//
//  Created by Apple on 5/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ShowTableViewController: UITableViewController {
    @IBOutlet weak var show_img: UIImageView!
    @IBOutlet weak var show_Name: UILabel!
    @IBOutlet weak var show_Note: UITextView!
    @IBOutlet weak var show_rating: RatingControl!
    @IBOutlet weak var show_cost: UILabel!
    var dataProducts: DataProducts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectProduct()
    }
    
    func selectProduct() {
        show_Name.text = dataProducts?.nameProducts
        show_img.image = dataProducts?.imageProducts as? UIImage
        show_cost.text = dataProducts?.totalProducts
        show_rating.rating = Int(dataProducts?.ratingProducts ?? 0)
        show_Note.text = dataProducts?.noteProducts
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "editCell":
            guard let addTableVC = segue.destination as? AddTableViewController else {return}
            addTableVC.detailItem = dataProducts
        default:
            return
        }
    }
}
