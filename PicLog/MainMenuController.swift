//
//  ViewController.swift
//  PicLog
//
//  Created by Riley Mills on 14/4/17.
//  Copyright © 2017 Riley Mills & Daniel Catania. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class MainMenuController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notes: [Note] = []
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let note = notes[indexPath.row]
        
        if let myLog = note.log {
            cell.textLabel?.text = myLog
        }
        
        return cell
    }
    
    func getData() {
        do {
            notes = try context.fetch(Note.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            context.delete(note)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                notes = try context.fetch(Note.fetchRequest())
            }
            catch {
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }
    
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "mySegue", sender:self)
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "mySegue"){
            //prepare for segue to the details view controller
            
            if let detailsVC = sender?.destination as? ViewNoteController {
                let indexPath = self.tableView.indexPathForSelectedRow
                detailsVC.viewNote = self.notes[indexPath!.row]
            }
        }
    }

}

    
    
    
    
    


