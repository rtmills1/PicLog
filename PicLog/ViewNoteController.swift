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
    
    var notes: [Note] = []
    
    var passedValue: String!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
  
    
    func loadImage(imageView: UIImageView){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        //Hold note value that will be saved into the Note Entity in CoreData
        let note = Note(context: context)
        
        if let imageData = note.value(forKey: "photo") as? NSData{
            if let image = UIImage(data:imageData as Data){
                imageView.image = image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("the passedValue is :\(passedValue)")
        noteLabel.text = passedValue
    
        
    }
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
}
