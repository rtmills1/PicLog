//
//  CameraController.swift
//  PicLog
//
//  Created by Daniel Catania on 5/5/17.
//  Copyright © 2017 Riley Mills & Daniel Catania. All rights reserved.
//

/* This idea to sort in reverse is from a user RAFAEL GARCIA at http://www.appcoda.com/ios-programming-camera-iphone-app/
 @IBAction func useCamera(_ sender: AnyObject) {
 
 if UIImagePickerController.isSourceTypeAvailable(
 UIImagePickerControllerSourceType.camera) {
 
 let imagePicker = UIImagePickerController()
 
 imagePicker.delegate = self
 imagePicker.sourceType =
 UIImagePickerControllerSourceType.camera
 imagePicker.mediaTypes = [kUTTypeImage as String]
 imagePicker.allowsEditing = false
 
 self.present(imagePicker, animated: true,
 completion: nil)
 newMedia = true
 }
 }

end RAFAEL GARCIA idea
*/

import UIKit
import MobileCoreServices

class CameraController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var newMedia: Bool?
    
    // Allows the user to use the camera function, allwoing them to take photos and save them to camera roll
    @IBAction func useCamera(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = true
        }
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
