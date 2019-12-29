//
//  ViewController.swift
//  DoList
//
//  Created by Dawid Jaskulski on 27/12/2019.
//  Copyright © 2019 Dawid Jaskulski. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    var items = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        /* OR LONGER VERSION
         
        if item.done == true{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }*/
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        items[indexPath.row].done = !items[indexPath.row].done
        
        self.saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do Item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            if (textfield.text != "" && textfield.text != nil)
            {
                var newItem = Item()
                newItem.title = textfield.text!
               
                self.items.append(newItem)
                
                self.saveItems()
            }
        }
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "Create new item"
            textfield = UITextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems()
    {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath!)
        }
        catch{
            print(error)
        }
        tableView.reloadData()
    }
    
    func loadItems()
    {
        if let data = try? Data(contentsOf: dataFilePath!)
        {
            let decoder = PropertyListDecoder()
            
            do
            {
                items = try decoder.decode([Item].self, from: data)
                
            }
            catch{
                print("error loading data\(error)")
            }
        }
    }
}
