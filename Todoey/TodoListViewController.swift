//
//  ViewController.swift
//  Todoey
//
//  Created by Dowon Kim on 30/08/2023.
//

import UIKit

class TodoListViewController: UITableViewController {

    //Hard Code Array items on startup view
    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - TableView DataSource Methods
    //❗️stub 1/2
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    
    //❗️stub 2/2
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]

        return cell
    }


}



/* NavBar tintColor & titleColor storyboard error fix :
 let appearance = UINavigationBarAppearance()
 appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
 appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
 appearance.backgroundColor = UIColor.systemBlue
 navigationItem.standardAppearance = appearance
 navigationItem.scrollEdgeAppearance = appearance
 */
