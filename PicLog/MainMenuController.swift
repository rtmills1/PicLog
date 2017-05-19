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
    
//This CoreData method I learnt from Bob Lee URL:https://blog.bobthedeveloper.io/beginners-guide-to-core-data-in-swift-3-85292ef4edd
    
    //Stores Note value to pass into ViewNoteController
    var valueToPass:String!
    
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
    
    //Stores retrieve tableview items from the Note Entity
    var notes: [Note] = []
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //Retrieves data from CoreData and reloads the tableview to ensure data is current
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
        print("You selected cell #\(indexPath.row)!")
        
        let IndexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: IndexPath)! as UITableViewCell
        
        //Get the note value from the selected tableview cell
        valueToPass = currentCell.textLabel?.text
        
        performSegue(withIdentifier: "mySegue", sender:self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "mySegue"){
            //prepare for segue to the details view controller
            if let viewController = segue.destination as? ViewNoteController{
            
            //Sends Note value to ViewNoteController
            viewController.passedValue = valueToPass
            print("current cell: \(valueToPass)")
            
            }
        }
    }
    
}



    
    
    
    
    


