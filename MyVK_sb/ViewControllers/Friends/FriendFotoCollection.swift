//
//  FriendFotoCollection.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 23.10.2020.
//

import UIKit
import Kingfisher

// MARK: - FriendFotoCollection

class FriendFotoCollection: UICollectionViewController {
    
    //MARK: - Private properties
    
    private lazy var reuseCell = CellIds.collectionCell
    private lazy var networkService = NetworkService()
    private lazy var userPhotos = [Photo]()
    public var userId = Int()

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserPhotos()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCell, for: indexPath) as? FotoCell else { return UICollectionViewCell() }
        cell.avatar.kf.setImage(with: URL(string: userPhotos[indexPath.row].url))
        
        return cell
    }
}

private extension FriendFotoCollection {
    func getUserPhotos() {
        networkService.loadPhotos(owner_id: userId) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let photos):
                    self.userPhotos = photos
                }
                self.collectionView.reloadData()
            }
        }
    }
}
