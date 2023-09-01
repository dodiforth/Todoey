//
//  ViewController.swift
//  Todoey
//
//  Created by Dowon Kim on 30/08/2023.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var todoItems: Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarAndTitleColor()
        
        //to get a path to where the data is being stored for the current app
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    //⚠️ NavBar tintColor & titleColor storyboard error fix :
    func setupNavBarAndTitleColor() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.systemBlue
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    // MARK: - TableView DataSource Methods
    //❗️stub 1/2
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    //❗️stub 2/2
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        //
        //        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }

            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            print("NOW")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Data Manipulation Methods
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        self.tableView.reloadData()
    }
    
}

// MARK: - SearchBar Methods

//extension TodoListViewController: UISearchBarDelegate {
//
//    // ✅ Searching and showin the result character by charcter on real time
//    // ❇️ Cancel(or erase) the text on search bar make going back to the original list
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        if searchBar.text == "" {
//            loadItems()
//            //❤️
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        } else {
//            loadItems(with: request, predicate: predicate)
//        }
//
//    }

// ❗️ Showing the result only by the end of typing.
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        //print(searchBar.text)
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadItems(with: request)
//    }

//}


