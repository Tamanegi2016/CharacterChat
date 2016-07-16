//
//  FriendTableViewController.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Kazuhiro Hayashi All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController {

    var friends = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: UserManager.Notif.didLogout, object: nil, queue: OperationQueue.main) { [weak self] (notif) in
            self?.fetch()
        }
        
        NotificationCenter.default.addObserver(forName: UserManager.Notif.didLogin, object: nil, queue: OperationQueue.main) { [weak self] (notif) in
            self?.friends = []
            self?.tableView.reloadData()
        }
        
        fetch()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FriendTableViewController.didRefresh(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
    }

    func didRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        fetch()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as! FriendTableViewCell
        cell.nameLabel.text = friends[indexPath.row].name
        return cell
    }


    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    
    private func fetch() {
        UserManager.sharedInstance.requestFriends(complate: { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.friends = data
            case .failure(_):
                self?.friends = []
            }
            self?.tableView.reloadData()
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UserManager.Notif.didLogout, object: nil)
        NotificationCenter.default.removeObserver(self, name: UserManager.Notif.didLogin, object: nil)
    }
}
