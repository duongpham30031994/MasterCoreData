//
//  AddTableViewController.swift
//  MasterCoreData
//
//  Created by Apple on 5/15/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var txt_nameEdit: UITextField!
    @IBOutlet weak var txt_TotalEdit: UITextField!
    @IBOutlet weak var txt_NoteEdit: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var rating: RatingControl!
    var detailItem : DataProducts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ----------------------------- Start su ly Photo in Library ---------------------------------------
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }

    // -------------------------------- End xu ly Photo in Library ----------------------------------------
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            txt_nameEdit.text = detail.nameProducts
            txt_TotalEdit.text = "\(detail.totalProducts!)"
            photoImageView.image = detail.imageProducts as? UIImage
            rating.rating = Int(detail.ratingProducts)
            txt_NoteEdit.text = detail.noteProducts
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addTableViewController = segue.destination as? MainTableViewController {
            let context = addTableViewController.fetchedResultsController.managedObjectContext
            if addTableViewController.tableView.indexPathForSelectedRow == nil {
                detailItem = DataProducts(context: context)
            }
            detailItem?.nameProducts = txt_nameEdit.text
            detailItem?.totalProducts = txt_TotalEdit.text
            detailItem?.imageProducts = photoImageView.image
            detailItem?.ratingProducts = Int32(rating.rating)
            detailItem?.noteProducts = txt_NoteEdit.text
            CoreDataServices.shared.saveContext()
        }
    }
}

