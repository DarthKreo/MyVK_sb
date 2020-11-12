//
//  MyGroupsTable.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 23.10.2020.
//

import UIKit

// MARK: - MyGroupsTable

class MyGroupsTable: UITableViewController {
    
    //MARK: - Private properties
    
    private lazy var cellIdentifire = CellIds.tableCell
    private lazy var myGroups = [Object]()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControlView()
    }
    
    //MARK: - Actions
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            guard let allGroupsControl = segue.source as? AllGroupsTable
            else { return }
            if let indexPath = allGroupsControl.tableView.indexPathForSelectedRow {
                let group = allGroupsControl.groups[indexPath.row]
                if !myGroups.contains(group) {
                    myGroups.append(group)
                    tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - Setup

extension MyGroupsTable {
    func setupControlView() {
        let nibCell = UINib(nibName: cellIdentifire, bundle: nil)
        self.tableView.register(nibCell, forCellReuseIdentifier: cellIdentifire)
        self.tableView.rowHeight = 66
    }
}

// MARK: - Table view data source, delegate

extension MyGroupsTable {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let
                cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire,
                                                     for: indexPath) as? DefaulCell
        else { return UITableViewCell() }
        
        cell.circleShadow.isHidden = true
        cell.nameLabel.text = myGroups[indexPath.row].name
        cell.avatarImage.image = UIImage(named: myGroups[indexPath.row].avatar)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
