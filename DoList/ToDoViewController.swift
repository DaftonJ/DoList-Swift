//
//  ViewController.swift
//  DoList
//
//  Created by Dawid Jaskulski on 27/12/2019.
//  Copyright © 2019 Dawid Jaskulski. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    var items = ["Buy Milk", "Go for a Walk","Eat something"]
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let itemsArray = defaults.array(forKey: "ToDoItems") as? [String]
        {
            items = itemsArray
        }
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
       {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
       {
         tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do Item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            if (textfield.text != "" && textfield.text != nil)
            {
                self.items.append(textfield.text!)
                
                self.defaults.set(self.items, forKey: "ToDoItems")
                
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "Create new item"
            textfield = UITextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

