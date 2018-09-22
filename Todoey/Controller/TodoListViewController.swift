//
//  ViewController.swift
//  Todoey
//
//  Created by Jettapol Tuetrakul on 21/9/2561 BE.
//  Copyright © 2561 Jettapol Tuetrakul. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{

    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    @IBOutlet weak var categoryTitle: UINavigationItem!
    
    var selectedCategory : Category? {
        didSet{
            //these happen after selectedCategory get set value
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        }
        else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }

//MARK: - Tableview Delegate Methods : Get fired everytime user click cell in Table View
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // revert done status
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
//                    realm.delete(item)
                }
            }
            catch {
                print("Error saving new items, \(error)")
            }
        }
        
        //Deselct cell after click (Make the dark background disappear)
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }
    
//MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happend when user click Add Item

//            //Add new Item
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }
                catch {
                    print("Error saving new items, \(error)")
                }
            }
            
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
    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    
}
//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(with: searchBar.text!)

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        else {
            search(with: searchBar.text!)
        }
    }

    func search(with key: String){
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", key).sorted(byKeyPath: "dateCreated", ascending: false)
        
        tableView.reloadData()
        
    }
}

