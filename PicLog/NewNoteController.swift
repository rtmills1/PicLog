//
//  ViewController2.swift
//  PicLog
//
//  Created by Riley Mills on 25/4/17.
//  Copyright © 2017 Riley Mills & Daniel Catania. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class NewNoteController: UIViewController {
    
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
    
    
}
