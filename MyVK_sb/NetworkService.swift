//
//  NetworkService.swift
//  MyVK_sb
//
//  Created by Владимир Кваша on 13.11.2020.
//

import Foundation
import Alamofire
import UIKit

// MARK: - NetworkService

class NetworkService {
    
    private lazy var baseUrl = "https://api.vk.com"
    
    //https://vk.com/dev/friends.get?params[user_id]=13917202&params[order]=name&params[count]=10&params[offset]=5&params[fields]=nickname%2C%20photo_50&params[name_case]=ins&params[v]=5.126
    

    func loadGroups() {
        
    let groupsPath = "/method/groups.get"
    let paramsForGroups: Parameters = [
            "access_token" : Session.instance.token,
            "extended" : 1,
            "v" : "5.85"]
        
        AF.request(baseUrl + groupsPath, method: .get, parameters: paramsForGroups).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }
    
    func loadFriends() {
        
       let friendsPath = "/method/friends.get"
       let paramsForFriends: Parameters = [
            "access_token" : Session.instance.token,
            "order" : "hints",
            "count" : 10,
            "fields" : "photo_50",
            "v" : "5.85"]
        
        AF.request(baseUrl + friendsPath, method: .get, parameters: paramsForFriends).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }
    
    func loadPhotos(owner_id: String) {
        
        let photosPath = "/method/photos.getAll"
        let paramsForPhotos: Parameters = [
            "access_token" : Session.instance.token,
            "owner_id" : owner_id,
            "count" : 10,
            "no_service_albums" : 1,
            "v" : "5.85"]
        
        AF.request(baseUrl + photosPath, method: .get, parameters: paramsForPhotos).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }
    
    func searchGroups(byString: String) {
        let searchGroupsPath = "/method/groups.search"
        let paramsForSearch: Parameters = [
            "access_token" : Session.instance.token,
            "q" : byString,
            "type" : "groups",
            "count" : "5",
            "v" : "5.85"]
        
        AF.request(baseUrl + searchGroupsPath, method: .get, parameters: paramsForSearch).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
        }
    }
}
