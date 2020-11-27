//
//  NetworkService.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 13.11.2020.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

// MARK: - NetworkService

class NetworkService {
    
    //MARK: - Private properties
    
    private lazy var baseUrl = "https://api.vk.com"
    
    // MARK: - Public methods
    
   public func loadGroups(completion: @escaping(Result<[Group], Error>) -> Void) {
        
        let groupsPath = "/method/groups.get"
        let paramsForGroups: Parameters = [
            "access_token" : Session.instance.token,
            "extended" : 1,
            "v" : "5.85"]
        
        AF.request(baseUrl + groupsPath,
                   method: .get,
                   parameters: paramsForGroups).responseJSON { response in
                    switch response.result {
                    
                    case .success(let value):
                        let json = JSON(value)
                        let groups = json["response"]["items"].arrayValue.map {
                            Group(json: $0) }
                        completion(.success(groups))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                   }
    }
    
    public func loadFriends(completion: @escaping(Result<[Friend], Error>) -> Void) {
        
        let friendsPath = "/method/friends.get"
        let paramsForFriends: Parameters = [
            "access_token" : Session.instance.token,
            "order" : "hints",
            "count" : 10,
            "fields" : "photo_50",
            "v" : "5.85"]
        
        AF.request(baseUrl + friendsPath,
                   method: .get,
                   parameters: paramsForFriends).responseJSON { response in
                    
                    switch response.result {
                    
                    case .success(let value):
                        let json = JSON(value)
                        let friends = json["response"]["items"].arrayValue.map { Friend(json: $0) }
                        completion(.success(friends))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                   }
    }
    
    public func loadPhotos(owner_id: Int, completion: @escaping(Result<[Photo], Error>) -> Void) {
        
        let photosPath = "/method/photos.getAll"
        let paramsForPhotos: Parameters = [
            "access_token" : Session.instance.token,
            "owner_id" : owner_id,
            "count" : 20,
            "no_service_albums" : 1,
            "v" : "5.85"]
        
        AF.request(baseUrl + photosPath,
                   method: .get,
                   parameters: paramsForPhotos).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let photos = json["response"]["items"].arrayValue.map { Photo(json: $0)}
                completion(.success(photos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func searchGroups(byString: String, completion: @escaping(Result<[Group], Error>) -> Void) {
        let searchGroupsPath = "/method/groups.search"
        let paramsForSearch: Parameters = [
            "access_token" : Session.instance.token,
            "q" : byString,
            "type" : "groups",
            "count" : "5",
            "v" : "5.85"]
        
        AF.request(baseUrl + searchGroupsPath, method: .get, parameters: paramsForSearch).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let neededGroups = json["response"]["items"].arrayValue.map {
                    Group(json: $0) }
                completion(.success(neededGroups))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
