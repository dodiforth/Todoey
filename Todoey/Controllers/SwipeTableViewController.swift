//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Dowon Kim on 02/09/2023.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60.0
    }
    
    // MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
                cell.delegate = self
                return cell
    }


    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.updateMode(at: indexPath)

            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        return [deleteAction]
    }
    
    // customize the behavior of the swipe actions: Destructive -> Fully swipe to delete (only 1 gesture)
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
   
    func updateMode(at indexPath: IndexPath) {
        //Update the Data Model
    }
}
