//
//  CategoriesTableViewController.swift
//  DoList
//
//  Created by Dawid Jaskulski on 03/01/2020.
//  Copyright © 2020 Dawid Jaskulski. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UITableViewController {

   
        var categories = [Category]()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
      
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            loadItems()
            
        }

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            
            cell.textLabel?.text = categories[indexPath.row].name
    
            return cell
        }

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "goToItems", sender: self)
        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoViewController
        destinationVC.currentCategory = categories[tableView.indexPathForSelectedRow!.row]
    }
     @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            
                       var textfield = UITextField()
                       
                       let alert = UIAlertController(title: "Add New To Do Category", message: nil, preferredStyle: .alert)
        
                       let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
                           if (textfield.text != "" && textfield.text != nil)
                           {
                            let newCategory = Category(context: self.context)
                               newCategory.name = textfield.text!
                              
                               self.categories.append(newCategory)
                               
                               self.saveItems()
                           }
                       }
                       alert.addTextField { (UITextField) in
                           UITextField.placeholder = "Create new Category"
                           textfield = UITextField
                       }
                       
                       alert.addAction(action)
                       
                       present(alert, animated: true, completion: nil)
        }
        
        func saveItems()
        {
        
            do{
                try context.save()
            }
            catch{
                print(error)
            }
            tableView.reloadData()
        }
        //Calling function with default request if not using other request
        func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest())
        {
            do
            {
                categories = try context.fetch(request)
            }
            catch
            {
                print("Error fetching data \(error)")
            }
            
            tableView.reloadData()
        }
    }

