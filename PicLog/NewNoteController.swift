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
    
    @IBOutlet weak var imageView: UIImageView!
    var newMedia: Bool?
    
    //Textfield that captures user inputs note into
    @IBOutlet weak var noteTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This CoreData method I learnt from Bob Lee URL:https://blog.bobthedeveloper.io/beginners-guide-to-core-data-in-swift-3-85292ef4edd
    
    //Function linked to the Save button in the bottom bar of screen
    @IBAction func buttonTapped(_ sender: UIBarButtonItem) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //Hold note value that will be saved into the Note Entity in CoreData
        let note = Note(context: context)
        //Accesses the user text from the textfield
        note.log = noteTextField.text!
        // Save the data to coredata
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        let _ = navigationController?.popViewController(animated: true)
    }
    
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
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true,
                         completion: nil)
        }
    }
    
    
}
