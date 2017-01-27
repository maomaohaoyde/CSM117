//
//  ViewController.swift
//  playwithtable view
//
//  Created by Wang Jingtao on 5/29/16.
//  Copyright © 2016 Bruin App Builder. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var  friendsArray = [FriendItem]()
    var filteredFriends = [FriendItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.friendsArray+=[FriendItem(name:"Beef Noodle Soup")]
        self.friendsArray+=[FriendItem(name:"Orange Chicken")]
        self.friendsArray+=[FriendItem(name:"Dim Sum")]
        self.friendsArray+=[FriendItem(name:"Peking Duck")]
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView==self.searchDisplayController?.searchResultsTableView)
        {
            return self.filteredFriends.count
    }
        else
        {
            return self.friendsArray.count
        }

}
    func tableView(_ tableView: UITableView, accessoryTypeForRowWithIndexPath indexPath: IndexPath) -> UITableViewCell{
        let cell=self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        var friend : FriendItem
        if (tableView==self.searchDisplayController?.searchResultsTableView)
        {
            friend = self.filteredFriends[indexPath.row]
        }
        else
        {
            friend=self.friendsArray[indexPath.row]
        }
        cell.textLabel?.text=friend.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var friend:FriendItem
        if (tableView==self.searchDisplayController?.searchResultsTableView)
        {
            friend = self.filteredFriends[indexPath.row]
        }
        else
        {
            friend=self.friendsArray[indexPath.row]
        }
        print(friend.name)

    }
    
    func filterContentForSearchText(_ searchText: String, scope:String="Title")
    {
        self.filteredFriends=self.friendsArray.filter({(friend:FriendItem)->Bool in
            let categoryMatch=(scope=="Title")
            let stringMatch = friend.name.range(of: searchText)
            return categoryMatch && (stringMatch != nil)
        })
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool {
        self.filterContentForSearchText(searchString!, scope: "Title")
        return true
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText((self.searchDisplayController?.searchBar.text)!, scope: "Title")
        return true
    }
    
    
}


