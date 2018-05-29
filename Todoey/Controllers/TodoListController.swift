//
//  TodoListController.swift
//  Todoey
//
//  Created by Andres Vazquez on 2018-05-28.
//  Copyright © 2018 Andres Vazquez. All rights reserved.
//

import UIKit

class TodoListController: UITableViewController {
    
    // MARK: - IB Outlets
    /**************************************************/
    
    
    
    
    
    // MARK: - Variables
    /**************************************************/
    
    let sampleData = ["First Item", "Second Item", "Third Item"]
    let cellID = "TodoItemCell"
    let todoItemCellNib = UINib(nibName: "TodoItemCell", bundle: nil)
    
    
    // MARK: - Methods
    /**************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(todoItemCellNib, forCellReuseIdentifier: cellID)
    }
    
    
    
    // MARK: - IB Actions
    /**************************************************/
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
    }
    
    
    
    // MARK: - UITableView Methods
    /**************************************************/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TodoItemCell
        cell.todoItemLabel.text = sampleData[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
