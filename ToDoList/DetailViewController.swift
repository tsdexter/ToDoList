//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Thomas Dexter on 2019-04-09.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var item: ToDoItem
    var listManager: ToDoListManager
    
    init(item: ToDoItem, listManager: ToDoListManager) {
        self.item = item
        self.listManager = listManager
        
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Cannot be created from storyboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add values to views
        updateViews();
        
        view.addSubview(backButton)
        view.addSubview(descriptionLabel)
        view.addSubview(dateCreatedLabel)
        view.addSubview(completedSwitch)
        view.addSubview(dateCompletedLabel)
        
        view.setNeedsUpdateConstraints()
    }
    lazy var descriptionLabel: UILabel! = {
        let view = UILabel()
    
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.font = view.font.withSize(20)
        
        return view
    }()
    
    lazy var dateCreatedLabel: UILabel! = {
        let view = UILabel()
    
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.font = view.font.withSize(12)
        
        return view
    }()
    
    lazy var completedSwitch: UISwitch! = {
        let view = UISwitch()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.isOn = false
        
        view.addTarget(self, action: #selector(onSwitchSwitched), for: .valueChanged)
        
        return view
    }()
    
    lazy var backButton: UIButton! = {
        let view = UIButton()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.setTitle("Back", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .black
        view.addTarget(self, action: #selector(onBackClicked), for: .touchDown)
        
        return view
    }()
    
    lazy var dateCompletedLabel: UILabel! = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .right
        view.font = view.font.withSize(12)
        
        return view
    }()
    
    // toggle the completion of the item when switched
    @objc func onSwitchSwitched() {
        self.listManager.toggleCompleted(item: item)
        updateViews()
    }
    
    // go back to the previous view
    @objc func onBackClicked() {
        self.dismiss(animated: false, completion: nil)
    }
    
    // add the item data to the views
    func updateViews() {
        descriptionLabel.text = item.description
        dateCreatedLabel.text = item.dateCreatedAsString()
        completedSwitch.isOn = item.completed
        
        // set completed date
//        dateCompletedLabel.text = (item.completed ? "Completed at: " : "") + item.dateCompletedAsString()
    }
    
    override func updateViewConstraints() {
        let margins = view.layoutMarginsGuide
        
        backButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15).isActive = true
        backButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        
        dateCreatedLabel.topAnchor.constraint(equalTo: completedSwitch.bottomAnchor, constant: 10).isActive = true
        dateCreatedLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        
        completedSwitch.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30).isActive = true
        completedSwitch.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        
        dateCompletedLabel.topAnchor.constraint(equalTo: completedSwitch.bottomAnchor, constant: 10).isActive = true
        dateCompletedLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        
        super.updateViewConstraints()
    }
}
