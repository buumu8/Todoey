//
//  ViewController.swift
//  Todoey
//
//  Created by Jettapol Tuetrakul on 21/9/2561 BE.
//  Copyright © 2561 Jettapol Tuetrakul. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    var itemArray = [Item]()
    
    //Set user default
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        itemArray.append(Item(title: "Find Mike"))
        itemArray.append(Item(title: "Buy Eggos"))
        itemArray.append(Item(title: "Destroy Demogorgon"))
        for i in 1 ... 20 {
            itemArray.append(Item(title: "Destroy Demogorgon\(i)"))
        }
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }

    //Mark: - Tableview Delegate Methods : Get fired everytime user click cell in Table View
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        // revert done status
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //Deselct cell after click (Make the dark background disappear)
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Add checkmark to cell everytime it clicked
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
    }
    
    //Mark: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happend when user click Add Item

            //Add new Item
            self.itemArray.append(Item(title: textField.text!))
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            //Reload Data to Table View
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

