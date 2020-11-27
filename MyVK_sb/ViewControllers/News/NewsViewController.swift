//
//  NewsViewController.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 02.11.2020.
//

import UIKit

// MARK: - NewsViewController

final class NewsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var newsTable: UITableView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.newsCell) as? NewsCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}

// MARK: - Setup

private extension NewsViewController {
    func setupView() {
        setupNewsTable()
    }
}

// MARK: - Setups Views

private extension NewsViewController {
    func setupNewsTable() {
        let nib = UINib(nibName: CellIds.newsCell, bundle: nil)
        newsTable.register(nib, forCellReuseIdentifier: CellIds.newsCell)
        newsTable.dataSource = self
        newsTable.delegate = self
        newsTable.rowHeight = 352
    }
}
