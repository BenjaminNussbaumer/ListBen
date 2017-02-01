//
//  ViewController.swift
//  ListBen
//
//  Created by Benjamin Nussbaumer on 01/02/2017.
//  Copyright © 2017 Benjamin Nussbaumer. All rights reserved.
//

import UIKit
//Add below "import UIKit"
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    //Change “names” to “people” and [String] to [NSManagedObject]
    var people = [NSManagedObject]()
    
    
    
    @IBAction func addName(_ sender: Any) {
        

        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        let textField = alert.textFields!.first
                                        self.saveName(name: textField!.text!)
                                        self.tableView.reloadData()
                                        
                                        
                                        
        })
    
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,
                              animated: true,
                              completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tableView.register(UITableViewCell.self,
                                forCellReuseIdentifier: "Cell")
    }

    
    //tableview
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let person = people[indexPath.row]
        
        cell!.textLabel!.text =
            person.value(forKey: "name") as? String
        
        return cell!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    //SaveName
    func saveName(name: String) {
        //1
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
     
        
        //2
        let entity =  NSEntityDescription.entity(forEntityName: "Person",
                                                 in:managedContext)
        
        let person = NSManagedObject(entity: entity!,
                                     insertInto: managedContext)
        
        //3
        person.setValue(name, forKey: "name")
        
        //4
        do {
            try managedContext.save()
            //5
            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    

}

