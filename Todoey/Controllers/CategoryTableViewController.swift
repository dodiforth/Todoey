//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Dowon Kim on 01/09/2023.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var textField = UITextField()
    
    var categories = [`Category`]()
    
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    
    // MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    //❗️stub 2/2
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    // MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write{
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    func loadCategories() {
        //with request: NSFetchRequest<Category> = Category.fetchRequest()
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//        tableView.reloadData()
    }
    
    
    // MARK: - IBAction addButtonPressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = self.textField.text!
            self.categories.append(newCategory)
            
            self.save(category: newCategory)
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            self.textField = field
            self.textField.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    
}
