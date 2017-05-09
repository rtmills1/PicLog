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
    
    
}
