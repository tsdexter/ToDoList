//
//  ToDoItemCell.swift
//  ToDoList
//
//  Created by Thomas Dexter on 2019-04-09.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import UIKit

class ToDoItemCell: UITableViewCell {
    var toDoItem: ToDoItem? {
        didSet {
            if let item = toDoItem {
                
                // strikethrough the text if the item is completed
                if (item.completed) {
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item.description)
                    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                    descriptionLabel.attributedText = attributeString
                } else {
                    descriptionLabel.attributedText = nil
                    descriptionLabel.text = item.description
                }
                dateCreatedLabel.text = "Created at: " + item.dateCreatedAsString()
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateCreatedLabel)
        contentView.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Cannot be created from storyboard")
    }
    
    lazy var descriptionLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.textColor = UIColor.black
        view.font = view.font.withSize(16)
        
        return view
    }()
    
    lazy var dateCreatedLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.textColor = UIColor.black
        view.font = view.font.withSize(10)
        
        return view
    }()
    
    override func updateConstraints() {
        let margins = contentView.layoutMarginsGuide
        
        descriptionLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5).isActive = true
        
        dateCreatedLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        dateCreatedLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5).isActive = true
        
        super.updateConstraints()
    }
}
