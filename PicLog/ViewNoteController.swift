//
//  ViewNoteController.swift
//  PicLog
//
//  Created by Riley Mills on 5/5/17.
//  Copyright © 2017 Riley Mills & Daniel Catania. All rights reserved.
//

import UIKit


@available(iOS 10.0, *)
class ViewNoteController: UIViewController {
    
    //Note string send from tableview from cell clicked on
    var passedValue: String!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    //Image saved from imagepickercontroller in Userdefaults
    var retrievedImage = UserDefaults.standard.object(forKey: "image") as AnyObject
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("the passedValue is :\(passedValue)")
        
        //Display Note in the label
        noteLabel.text = passedValue
        
        //Display UIImage in imageview
        imageView.image = UIImage(data: (retrievedImage as! NSData) as Data)
        
    }
    
   
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
}
