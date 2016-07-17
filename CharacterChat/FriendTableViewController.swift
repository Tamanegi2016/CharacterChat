//
//  FriendTableViewController.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Kazuhiro Hayashi All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController, FriendRegistrationViewControllerDelegate {

    var friends = [User]()
    
    lazy var presentCharacterSelectView: (() -> Void)? = {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CharacterSelectViewController")
        vc?.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true) {
            UserDefaults.standard.set(true, forKey: "alreadySelectFriend")
            UserDefaults.standard.synchronize()
        }
        self.presentCharacterSelectView = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let alreadySelectFriend = UserDefaults.standard.bool(forKey: "alreadySelectFriend")
//        if alreadySelectFriend {
            presentCharacterSelectView = nil
//        }
        
        NotificationCenter.default.addObserver(forName: UserManager.Notif.didLogout, object: nil, queue: OperationQueue.main) { [weak self] (notif) in
            self?.friends = []
            self?.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: UserManager.Notif.didLogin, object: nil, queue: OperationQueue.main) { [weak self] (notif) in
            self?.fetch()
        }
        
        fetch()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FriendTableViewController.didRefresh(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentCharacterSelectView?()
    }
    
    func didRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        fetch()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? FriendRegistrationViewController {
            vc.delegate = self
        }
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
        ImageLoadManager.sharedInstance.load(with: friends[indexPath.row].profileImage) { (result) in
            switch result {
            case .success(let data):
                cell.profileImageView.image = UIImage(data: data)
            case .failure(_):
                break
            }
        }
        return cell
    }

    // MARK:- Segue
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    
    // MARK:- FriendRegistrationViewControllerDelegate
    func viewController(vc: FriendRegistrationViewController, didRegister user: User) {

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
