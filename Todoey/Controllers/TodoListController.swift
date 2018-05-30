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
    
    @IBOutlet weak var addItemBarButton: UIBarButtonItem!
    
    
    
    // MARK: - Variables
    /**************************************************/
    
    private var data = [TodoItem]()
    private let cellID = "TodoItemCell"
    private let todoItemCellNib = UINib(nibName: "TodoItemCell", bundle: nil)
    private var isInEditMode = false
    private var indexPathBeingEdited: IndexPath?
    private var nextBackgroundColor: CGFloat = 255
    
    
    // MARK: - Methods
    /**************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(todoItemCellNib, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        
        addLongPressRecognizer()
    }
    
    private func addLongPressRecognizer() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        tableView.addGestureRecognizer(longPressGesture)
    }
    
    private func toggleEditMode() {
        if isInEditMode {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemPressed))
            isInEditMode = false
        }
        else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleSaveItem))
            isInEditMode = true
        }
    }
    
    private func enableCellEditing(forIndexPath indexPath: IndexPath) {
        let cellItem = tableView.cellForRow(at: indexPath) as! TodoItemCell
        cellItem.titleTextField.isEnabled = true
        
        cellItem.titleTextField.becomeFirstResponder()
        cellItem.titleTextField.selectedTextRange = cellItem.titleTextField.textRange(from: cellItem.titleTextField.beginningOfDocument, to: cellItem.titleTextField.endOfDocument)
        
        indexPathBeingEdited = indexPath
    }
    
    
    // MARK: - IB Actions
    /**************************************************/
    
    @IBAction func addItemPressed() {
        data.append(TodoItem(title: "New Item", colorScheme: .red, colorValue: nextBackgroundColor))
        nextBackgroundColor = (nextBackgroundColor - 30 > 0) ? nextBackgroundColor - 30 : 0
        
        tableView.reloadData()
        
        let lastIdexPath = IndexPath(item: data.count - 1, section: 0)
        enableCellEditing(forIndexPath: lastIdexPath)
        toggleEditMode()
    }
    
    
    
    // MARK: - Event Handlers
    /**************************************************/
    
    @objc private func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        if isInEditMode {
            return
        }
        
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)
            
            if let indexPathLongPressed = tableView.indexPathForRow(at: touchPoint) {
                enableCellEditing(forIndexPath: indexPathLongPressed)
                toggleEditMode()
            }
        }
        
    }
    
    @objc private func handleSaveItem() {
        guard let indexPath = indexPathBeingEdited else { return }
        
        // Save edit
        data[indexPath.row].title = (tableView.cellForRow(at: indexPath) as! TodoItemCell).titleTextField.text!
        
        let lastItem = tableView.cellForRow(at: indexPath) as! TodoItemCell
        lastItem.titleTextField.isEnabled = false
        
        indexPathBeingEdited = nil
        toggleEditMode()
    }
    
    
    // MARK: - UITableView Methods
    /**************************************************/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TodoItemCell
        let todo = data[indexPath.row]
        cell.titleTextField.text = todo.title
        cell.titleTextField.textColor = .white
        cell.titleTextField.isEnabled = false
        cell.titleTextField.delegate = self
        cell.backgroundColor = todo.backgroundColor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
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

extension TodoListController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSaveItem()
        
        return true
    }
}
