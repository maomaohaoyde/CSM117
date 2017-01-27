//
//  OrderView.swift
//  Calculator
//
//  Created by Wang Jingtao on 5/30/16.
//  Copyright © 2016 ShirleyChen. All rights reserved.
//

import UIKit

class OrderView: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate
{
    @IBOutlet weak var Button: UIButton!
    var touched:Bool = false
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func FinishedAction(_ sender: AnyObject) {
        if Button.titleLabel!.text == "Finish" {
            touched = true
            self.tableView.reloadData()
            Button.setTitle("Send", for: UIControlState())
        }
        
        
    }
    var friendsArray = [FriendItem]()
    var filteredFriends = [FriendItem]()
    var selected = Set<String>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.allowsMultipleSelection = true
        self.friendsArray += [FriendItem(name: "Sushi")]
        self.friendsArray += [FriendItem(name: "Ramen")]
        self.friendsArray += [FriendItem(name: "Kentucky Fried Chicken")]
        self.friendsArray += [FriendItem(name: "Peaking Duck")]
        self.friendsArray += [FriendItem(name: "Wonton Soup")]
        self.friendsArray += [FriendItem(name: "Boiled Dumplings")]
        self.friendsArray += [FriendItem(name: "Fried Dumplings")]
        self.friendsArray += [FriendItem(name: "Beef Noodle Soup")]
        self.friendsArray += [FriendItem(name: "Orange Chicken")]
        self.friendsArray += [FriendItem(name: "Bulgogi")]
        self.friendsArray += [FriendItem(name: "Tofu Soup")]
        self.friendsArray += [FriendItem(name: "Pho")]
        self.friendsArray += [FriendItem(name: "Fried Rice")]
        self.friendsArray += [FriendItem(name: "Taco")]
        self.friendsArray += [FriendItem(name: "Burrito")]
        self.friendsArray += [FriendItem(name: "Sweet Tea")]
        self.friendsArray += [FriendItem(name: "Boba")]
        self.tableView.reloadData()
        
    }
    
    /*  func readSet (index:Int)->Set<String>.Element
     {
     return selected[selected.startIndex.advancedBy(index)]
     }
     
     func setCount (subtract:Int) ->Int
     {
     return selected.count-subtract
     }
     */
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.reloadData()
        print(selected.count)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if !touched {
            if (tableView == self.searchDisplayController?.searchResultsTableView)
            {
                return self.filteredFriends.count
            }
            else
            {
                return self.friendsArray.count
            }
        }
        else
        {
            
            return selected.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        var friend : FriendItem
        if !touched {
            if (tableView == self.searchDisplayController?.searchResultsTableView)
            {
                friend = self.filteredFriends[indexPath.row]
                
            }
            else
            {
                friend = self.friendsArray[indexPath.row]
            }
            
        }
        else
        {
            friend = FriendItem(name: selected[selected.startIndex.advancedBy(indexPath.row)])
        }
        
        cell.textLabel?.text = friend.name
        
        if selected.contains(friend.name) {
            
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
            
            
            print(selected.count)
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        var friend : FriendItem
        
        
        if (tableView == self.searchDisplayController?.searchResultsTableView)
        {
            friend = self.filteredFriends[indexPath.row]
            
            if !selected.contains(friend.name) {
                
                selected.insert(friend.name)            }
            
            
            
        }
        else
        {
            friend = self.friendsArray[indexPath.row]
            if !selected.contains(friend.name)
            {
                selected.insert(friend.name)
            }
            
        }
        
        print(friend.name)
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
    }
    
    // MARK: - Search Methods
    
    func filterContenctsForSearchText(_ searchText: String, scope: String = "Title")
    {
        
        self.filteredFriends = self.friendsArray.filter({( friend : FriendItem) -> Bool in
            
            let categoryMatch = (scope == "Title")
            let stringMatch = friend.name.rangeOfString(searchText)
            
            return categoryMatch && (stringMatch != nil)
            
        })
        
        
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool
    {
        
        self.filterContenctsForSearchText(searchString!, scope: "Title")
        
        return true
        
        
    }
    
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool
    {
        
        self.filterContenctsForSearchText(self.searchDisplayController!.searchBar.text!, scope: "Title")
        
        return true
        
    }
    
}


