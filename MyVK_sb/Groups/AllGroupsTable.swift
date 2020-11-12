//
//  AllGroupsTable.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 23.10.2020.
//

import UIKit

// MARK: - AllGroupsTable

class AllGroupsTable: UITableViewController {
    
    //MARK: - Private properties
    
    private lazy var cell = CellIds.tableCell
    lazy var groups: [Object] = {
        var array = [Object]()
        for index in 0...Groups.names.count - 1 {
            let element = Object(name: Groups.names[index], avatar: Groups.images[index])
            array.append(element)
        }
        return array
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControlView()
    }
}

// MARK: - Setup

extension AllGroupsTable {
    func setupControlView() {
        let nibCell = UINib(nibName: cell, bundle: nil)
        self.tableView.register(nibCell, forCellReuseIdentifier: cell)
        self.tableView.rowHeight = 66
    }
}

// MARK: - Table view data source, delegate

extension AllGroupsTable {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let
                tableCell = tableView.dequeueReusableCell(withIdentifier: cell,
                                                          for: indexPath) as? DefaulCell
        else { return UITableViewCell() }
        
        tableCell.circleShadow.isHidden = true
        tableCell.nameLabel.text = groups[indexPath.row].name
        tableCell.avatarImage.image = UIImage(named: groups[indexPath.row].avatar)
        
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addGroup", sender: self)
    }
}
