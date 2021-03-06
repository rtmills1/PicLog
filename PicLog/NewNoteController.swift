//
//  ViewController2.swift
//  PicLog
//
//  Created by Riley Mills and Daniel Catania on 25/4/17.
//  Copyright © 2017 Riley Mills & Daniel Catania. All rights reserved.
//

import UIKit
import MobileCoreServices

@available(iOS 10.0, *)
class NewNoteController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Declaring variable for the ImageViews
    @IBOutlet var imageView: UIImageView!
    var newMedia: Bool?
    
    //Textfield that captures user inputs note into
    @IBOutlet weak var noteTextField: UITextField!

    
    //*This CoreData method I learnt from Bob Lee URL:https://blog.bobthedeveloper.io/beginners-guide-to-core-data-in-swift-3-85292ef4edd
    //Function linked to the Save button in the bottom bar of screen
    @IBAction func buttonTapped(_ sender: UIBarButtonItem) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        //Hold note value that will be saved into the Note Entity in CoreData
        let note = Note(context: context)
        
        //Accesses the user text from the textfield
        note.log = noteTextField.text!
        
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
       
        //Returns back to MainMenuController
        let _ = navigationController?.popViewController(animated: true)
    }
    //*End of Bob Lee
   
    
    //This idea to sort in reverse is from a user RAFAEL GARCIA at http://www.appcoda.com/ios-programming-camera-iphone-app/
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
    
    // This idea to sort in reverse is from a user RAFAEL GARCIA at http://www.appcoda.com/ios-programming-camera-iphone-app/
    // Defines methods that your delegate object must implement to interact with the image picker interface.
    // Allows the user to pick an image in camera roll and display it in view controller with an image view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
            imageView.image = image
            
            //*Added into this function by Riley Mills
            //Deleted UserDefaults Object before creating new one
            let prefs = UserDefaults.standard
            prefs.removeObject(forKey: "image")
            //Syncs changes before entering new value
            prefs.synchronize()
            
            //Saves image selected from UIImagePickerController to UserDefaults
            let pngImage = UIImagePNGRepresentation(image)
            UserDefaults.standard.set(pngImage, forKey: "image")
            //*End of Riley Mills Additions
            

            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(NewNoteController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType.isEqual(to: kUTTypeMovie as String) {
                // Code to support video here
            }
        }
    }

    
    
    // This idea to sort in reverse is from a user RAFAEL GARCIA at http://www.appcoda.com/ios-programming-camera-iphone-app/
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
