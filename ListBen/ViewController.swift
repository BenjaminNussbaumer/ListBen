//
//  ViewController.swift
//  ListBen
//
//  Created by Benjamin Nussbaumer on 01/02/2017.
//  Copyright © 2017 Benjamin Nussbaumer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    //Insert below the tableView IBOutlet
    var names = [String]()
    
    
    @IBAction func addName(_ sender: Any) {
        

        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        let textField = alert.textFields!.first
                                        self.names.append(textField!.text!)
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

    

    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell!.textLabel!.text = names[indexPath.row]
        
        return cell!
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

