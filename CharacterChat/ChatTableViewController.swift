//
//  FrendTableViewController.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Kazuhiro Hayashi All rights reserved.
//

import UIKit

class ChatTableViewController: UITableViewController {
    var chats = [Chat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FriendTableViewController.didRefresh(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
        
        NotificationCenter.default.addObserver(forName: UserManager.Notif.didLogout, object: nil, queue: OperationQueue.main) { [weak self] (notif) in
            self?.fetch()
        }
        
        NotificationCenter.default.addObserver(forName: UserManager.Notif.didLogin, object: nil, queue: OperationQueue.main) { [weak self] (notif) in
            self?.chats = []
            self?.tableView.reloadData()
        }
        
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
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath)


        return cell
    }

    private func fetch() {
        UserManager.sharedInstance.requestChats(complate: { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.chats = data
            case .failure(_):
                self?.chats = []
            }
            self?.tableView.reloadData()
        })
    }
    
    
    // MARK:- Target-Action
    func didRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        fetch()
    }
    
    deinit {
        
    }
}
