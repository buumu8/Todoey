//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Jettapol Tuetrakul on 22/9/2561 BE.
//  Copyright © 2561 Jettapol Tuetrakul. All rights reserved.
//

import UIKit
import SwipeCellKit
import ChameleonFramework

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion

            self.updateModel(at: indexPath)
            
            }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        let editAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
            // handle action by updating model with deletion
            
            self.editModel(at: indexPath)
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        editAction.image = UIImage(named: "edit-icon")
        editAction.backgroundColor = UIColor.flatYellow
        
        return [deleteAction,editAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    
    func updateModel(at indexPath: IndexPath){
        print("update model")
    }
    
    func editModel(at indexPath: IndexPath){
        print("edit model")
    }

}
