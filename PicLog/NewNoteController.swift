//
//  ViewController2.swift
//  PicLog
//
//  Created by Riley Mills and Daniel Catania on 25/4/17.
//  Copyright © 2017 Riley Mills & Daniel Catania. All rights reserved.
//

/* This idea to sort in reverse is from a user RAFAEL GARCIA at http://www.appcoda.com/ios-programming-camera-iphone-app/
 @IBAction func useCameraRoll(_ sender: AnyObject) {
 
 if UIImagePickerController.isSourceTypeAvailable(
 UIImagePickerControllerSourceType.savedPhotosAlbum) {
 let imagePicker = UIImagePickerController()
 
 imagePicker.delegate = self
 imagePicker.sourceType =
 UIImagePickerControllerSourceType.photoLibrary
 imagePicker.mediaTypes = [kUTTypeImage as String]
 imagePicker.allowsEditing = false
 self.present(imagePicker, animated: true,
 completion: nil)
 newMedia = false
 }
 }
 
and
 
 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
 
 let mediaType = info[UIImagePickerControllerMediaType] as! NSString
 
 self.dismiss(animated: true, completion: nil)
 
 if mediaType.isEqual(to: kUTTypeImage as String) {
 let image = info[UIImagePickerControllerOriginalImage]
 as! UIImage
 
 imageView.image = image
 
 if (newMedia == true) {
 UIImageWriteToSavedPhotosAlbum(image, self,
 #selector(NewNoteController.image(image:didFinishSavingWithError:contextInfo:)), nil)
 } else if mediaType.isEqual(to: kUTTypeMovie as String) {
 // Code to support video here
 }
 
 }
 }

 
and
 
 func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer) {
 
 if error != nil {
 let alert = UIAlertController(title: "Fail",
 message: "Image failed",
 preferredStyle: UIAlertControllerStyle.alert)
 
 let cancelAction = UIAlertAction(title: "Okay",
 style: .cancel, handler: nil)
 
 alert.addAction(cancelAction)
 self.present(alert, animated: true,
 completion: nil)
 }
 }


end RAFAEL GARCIA idea
 */


import UIKit
import MobileCoreServices

@available(iOS 10.0, *)
class NewNoteController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Declaring variable for the ImageViews
    @IBOutlet weak var imageView: UIImageView!
    var newMedia: Bool?
    
    @IBOutlet weak var noteTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func buttonTapped(_ sender: UIBarButtonItem) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let note = Note(context: context)
        note.log = noteTextField.text!
        // Save the data to coredata
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        let _ = navigationController?.popViewController(animated: true)
    }
    
    // Uses the devces camera roll, allwoing the users to access photos from there device
    @IBAction func useCameraRoll(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = false
        }
    }
    
    // Defines methods that your delegate object must implement to interact with the image picker interface.
    // Allows the user to pick an image in camera roll and display it in view controller with an image view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
            imageView.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(NewNoteController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType.isEqual(to: kUTTypeMovie as String) {
                // Code to support video here
            }
            
        }
    }
    
    // Error messages for user if they incorrectly upload an image or fail to follow procedure
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer) {
        
        if error != nil {
            let alert = UIAlertController(title: "Fail",
                                          message: "Image failed",
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "Okay",
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true,
                         completion: nil)
        }
    }
    
    
}
