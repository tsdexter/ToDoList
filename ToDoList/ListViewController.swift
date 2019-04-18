//
//  ListViewController.swift
//  ToDoList
//
//  Created by Thomas Dexter on 2019-04-09.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var data:[ToDoItem]
    
    init() {
        // use different data for testing
        let item1: ToDoItem = ToDoItem(description: "Item 1")
        let item2: ToDoItem = ToDoItem(description: "Item 2")
        let item3: ToDoItem = ToDoItem(description: "Item 3")
        item2.toggleComplete()
        
        self.data = [item1, item2, item3]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Cannot be created from Storyboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.setNeedsUpdateConstraints()
    }
    
    // reset the data when the view reappears as the user may have changed the completion
    // status on the detail view page
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    lazy var titleLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "ToDo List"
        view.textAlignment = .center
        view.font = view.font.withSize(20)
        
        return view
    }()
    
    lazy var tableView: UITableView! = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        view.tableFooterView = UIView(frame: .zero)
        view.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 40, right: 0)
        
        view.dataSource = self
        view.delegate = self
        view.register(ToDoItemCell.self, forCellReuseIdentifier: NSStringFromClass(ToDoItemCell.self))
        
        return view
    }()
    
    lazy var addButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Add", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .black
        view.addTarget(self, action: #selector(onAddClicked), for: .touchDown)
        return view
    }()
    
    @objc func onAddClicked() {
        let dialog = UIAlertController(title: "Add Item", message: "", preferredStyle: UIAlertController.Style.alert)
        dialog.addTextField { (textField) in
            textField.placeholder = "What do you need to do?"
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        dialog.addAction(cancelButton)
        let saveButton = UIAlertAction(title: "Save", style: UIAlertAction.Style.default) { (action) in
            if let itemField = dialog.textFields?[0] {
                if let item = itemField.text {
                    let toDoItem = ToDoItem(description: item)
                    self.data.append(toDoItem)
                    self.tableView.reloadData()
                }
            }
        }
        dialog.addAction(saveButton)
        present(dialog, animated: true, completion: nil)
    }
    
    override func updateViewConstraints() {
        let margins = view.layoutMarginsGuide
        
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        addButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true
        addButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 5).isActive = true
        
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        super.updateViewConstraints()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ToDoItemCell.self), for: indexPath) as! ToDoItemCell
        
        cell.toDoItem = data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        let detailView: DetailViewController = DetailViewController(item: item)
        self.present(detailView, animated: false, completion: nil)
    }
}

extension ListViewController: UITableViewDelegate {
    
}

