//
//  MyGroupsTable.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 23.10.2020.
//

import UIKit
import RealmSwift

// MARK: - MyGroupsTable

class MyGroupsTable: UITableViewController {
    
    //MARK: - Private properties
    
    private lazy var cellIdentifire = CellIds.tableCell
    private lazy var networkService = NetworkService()
    private var myGroups: Results<Group>?
    private var notificationToken: NotificationToken?
    let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControlView()
        getMyGroups()
    }
    
    //MARK: - Actions
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            guard let allGroupsControl = segue.source as? AllGroupsTable
            else { return }
//            if let indexPath = allGroupsControl.tableView.indexPathForSelectedRow {
//                guard let group = allGroupsControl.groups?[indexPath.row] else { return }
//                let myGroupsID = myGroups.map {$0.id}
//                if !myGroupsID.contains(group.id) {
//                    myGroups.append(group)
                    tableView.reloadData()
//                }
//            }
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
    
    func getMyGroups() {
        networkService.loadGroups { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let myGroups):
                    RealmProvider.save(items: myGroups, config: self.config)
                }
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Table view data source, delegate

extension MyGroupsTable {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let
                cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire,
                                                     for: indexPath) as? DefaulCell,
        let myGroup = myGroups?[indexPath.row]
        else { return UITableViewCell() }
        
        cell.configure(for: myGroup)
        cell.avatarImage.layer.cornerRadius = (self.tableView.rowHeight - 20) / 2
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let group = myGroups?[indexPath.row] else { return }
            RealmProvider.delete([group], config: config)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
