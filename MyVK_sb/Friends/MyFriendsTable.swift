//
//  MyFriendsTable.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 23.10.2020.
//

import UIKit

// MARK: - MyFriendsTable

class MyFriendsTable: UITableViewController {
    
    //MARK: - Private properties

    private lazy var cellReuse = CellIds.tableCell
    struct Section {
        let letter: String
        let names: [String]
    }
    
    private lazy var sections = [Section]()
    private lazy var filteredSections = [Section]()
    
    @IBOutlet weak var friendSearch: UISearchBar!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        alphabetSort()
        
        filteredSections = sections
        friendSearch.delegate = self
    }
    
    //MARK: - Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            friendSearch.resignFirstResponder()
        }
        super.touchesBegan(touches, with: event)
    }

}

private extension MyFriendsTable {
    func alphabetSort() {
        let groupedDictionary = Dictionary(grouping: Data.names, by: { String($0.prefix(1))})
        let keys = groupedDictionary.keys.sorted()
        sections = keys.map{ Section(letter: $0, names: groupedDictionary[$0]!.sorted()) }
        self.tableView.reloadData()
        }
    }


// MARK: - Setup

extension MyFriendsTable {
    func setupTable() {
        let nibCell = UINib(nibName: cellReuse, bundle: nil)
        self.tableView.register(nibCell, forCellReuseIdentifier: cellReuse)
        self.tableView.rowHeight = 88
        self.tableView.keyboardDismissMode = .onDrag
    }
}
// MARK: - Table view data source

extension MyFriendsTable {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredSections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSections[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuse, for: indexPath) as? DefaulCell
        else { return UITableViewCell() }
        
        cell.circleShadow.layer.backgroundColor = UIColor.clear.cgColor
        cell.avatarImage.image = UIImage(named: Data.avatars[0])
        cell.avatarImage.layer.cornerRadius = (self.tableView.rowHeight - 20) / 2
        let section = filteredSections[indexPath.section]
        let username = section.names[indexPath.row]
        cell.nameLabel.text = username
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return filteredSections.map{$0.letter}
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredSections[section].letter
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showFoto", sender: self)
    }
}

// MARK: - UISearchBarDelegate

extension MyFriendsTable: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredSections = []
        var namesNew = [String]()
        if searchText == "" {
            filteredSections = sections
        } else {
            for index in sections {
                for name in index.names {
                    if name.lowercased().contains(searchText.lowercased()) {
                        namesNew.append(name)
                    }
                }
                if !namesNew.isEmpty {
                    filteredSections.append(Section(letter: index.letter, names: namesNew))
                    namesNew = []
                }
            }
        }
        self.tableView.reloadData()
    }
}
