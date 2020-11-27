//
//  MyFriendsTable.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 23.10.2020.
//

import UIKit
import Kingfisher
import RealmSwift

// MARK: - MyFriendsTable

class MyFriendsTable: UITableViewController {
    
    //MARK: - Private properties
    
    private lazy var networkService = NetworkService()
    private lazy var cellReuse = CellIds.tableCell
    private var friends: Results<Friend>?
    let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    //    private lazy var friends = [Friend]()
    
    //    struct Section {
    //        let letter: String
    //        let names: [String]
    //    }
    //
    //    private lazy var sections = [Section]()
    //    private lazy var filteredSections = [Section]()
    
    @IBOutlet weak var friendSearch: UISearchBar!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        getFriends()
        
        
        //alphabetSort()
        
        //filteredSections = sections
        //friendSearch.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showFoto",
              let fotoVC = segue.destination as? FriendFotoCollection,
              let row = tableView.indexPathForSelectedRow?.row else { return }
        fotoVC.userId = friends?[row].id ?? 0
    }
    
    //MARK: - Actions
    
}

//private extension MyFriendsTable {
//    func alphabetSort() {
//        let groupedDictionary = Dictionary(grouping: Data.names, by: { String($0.prefix(1))})
//        let keys = groupedDictionary.keys.sorted()
//        sections = keys.map{ Section(letter: $0, names: groupedDictionary[$0]!.sorted()) }
//        self.tableView.reloadData()
//        }
//    }


// MARK: - Setup

extension MyFriendsTable {
    func setupTable() {
        let nibCell = UINib(nibName: cellReuse, bundle: nil)
        self.tableView.register(nibCell, forCellReuseIdentifier: cellReuse)
        self.tableView.rowHeight = 88
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    func getFriends() {
        networkService.loadFriends() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let friends):
                    RealmProvider.save(items: friends, config: self.config)
                }
            }
        }
        do {
            try friends = RealmProvider.load(Friend.self, config: config)
        } catch {
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
    }
}
// MARK: - Table view data source

extension MyFriendsTable {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuse, for: indexPath) as? DefaulCell,
              let friend = friends?[indexPath.row]
        else { return UITableViewCell() }
        
        cell.configure(for: friend)
        cell.avatarImage.layer.cornerRadius = (self.tableView.rowHeight - 20) / 2
        //        cell.circleShadow.layer.backgroundColor = UIColor.clear.cgColor
        //        cell.avatarImage.image = UIImage(named: Data.avatars[0])
        
        //
        //        let username = section.names[indexPath.row]
        //        cell.nameLabel.text = username
        return cell
    }
    
    //    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    //        return filteredSections.map{$0.letter}
    //    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Popular"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let collection = FriendFotoCollection()
        //        collection.userId = friends[indexPath.row].id
        performSegue(withIdentifier: "showFoto", sender: tableView)
    }
}

// MARK: - UISearchBarDelegate

//extension MyFriendsTable: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredSections = []
//        var namesNew = [String]()
//        if searchText == "" {
//            filteredSections = sections
//        } else {
//            for index in sections {
//                for name in index.names {
//                    if name.lowercased().contains(searchText.lowercased()) {
//                        namesNew.append(name)
//                    }
//                }
//                if !namesNew.isEmpty {
//                    filteredSections.append(Section(letter: index.letter, names: namesNew))
//                    namesNew = []
//                }
//            }
//        }
//        self.tableView.reloadData()
//    }
//}
