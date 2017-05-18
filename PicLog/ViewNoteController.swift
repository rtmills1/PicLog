//
//  ViewNoteController.swift
//  PicLog
//
//  Created by Riley Mills on 5/5/17.
//  Copyright © 2017 Riley Mills & Daniel Catania. All rights reserved.
//

import UIKit


class ViewNoteController: UIViewController {
    
    
    var passedValue: String!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    
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
