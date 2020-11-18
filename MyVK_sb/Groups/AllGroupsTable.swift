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
    
    private lazy var cellId = CellIds.tableCell
    private lazy var networkService = NetworkService()
    lazy var groups = [Group]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var groupSearchBar: UISearchBar!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControlView()
        groupSearchBar.delegate = self
    }
}

// MARK: - Setup

extension AllGroupsTable {
    func setupControlView() {
        let nibCell = UINib(nibName: cellId, bundle: nil)
        self.tableView.register(nibCell, forCellReuseIdentifier: cellId)
        self.tableView.rowHeight = 66
        self.tableView.keyboardDismissMode = .onDrag
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
                cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                          for: indexPath) as? DefaulCell
        else { return UITableViewCell() }
        
        cell.configure(for: groups[indexPath.row])
        cell.avatarImage.layer.cornerRadius = (self.tableView.rowHeight - 20) / 2
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addGroup", sender: self)
    }
}

// MARK: - UISearchBarDelegate

extension AllGroupsTable: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        networkService.searchGroups(byString: searchText) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let groups):
                    self.groups = groups
                }
                self.tableView.reloadData()
            }
        }
    }
}
