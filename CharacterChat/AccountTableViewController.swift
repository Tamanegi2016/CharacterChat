//
//  AccountTableViewController.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Kazuhiro Hayashi All rights reserved.
//

import UIKit

class AccountTableViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var contentCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentBottomConstraint: NSLayoutConstraint!
    
    var inputUserName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = 50
        
        nameLabel.text = UserManager.sharedInstance.own?.name
        ImageLoadManager.sharedInstance.load(with: UserManager.sharedInstance.own?.profileImage) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.profileImageView?.image = UIImage(data: data)
            case .failure(_):
                break
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(AccountTableViewController.keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AccountTableViewController.keyboardDidHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AccountTableViewController.keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(forName: UserManager.Notif.didLogout, object: nil, queue: OperationQueue.main) { [weak self] (notif) in
            self?.nameLabel.text = "ゲスト"
            self?.profileImageView?.image = UIImage(named: "NoProfile")
        }
        
        NotificationCenter.default.addObserver(forName: UserManager.Notif.didLogin, object: nil, queue: OperationQueue.main) { [weak self] (notif) in
            self?.nameLabel.text = UserManager.sharedInstance.own?.name
            ImageLoadManager.sharedInstance.load(with: UserManager.sharedInstance.own?.profileImage) { [weak self] (result) in
                switch result {
                case .success(let data):
                    self?.profileImageView?.image = UIImage(data: data)
                case .failure(_):
                    break
                }
            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileImageView.image = profileImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapLoginButton(_ sender: UIButton) {
        if let name = inputUserName where !name.isEmpty {
            UserManager.sharedInstance.login(with: name)
        }
    }
    
    enum KeyboardState {
        case showed
        case hidden
    }
    
    var keyboardState: KeyboardState = .hidden
    
    func keyboardWillChange(notification: Notification) {
        if let value = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? CGFloat,
            curve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? CGFloat {
            
            switch keyboardState {
            case .hidden:
                contentBottomConstraint.constant = value.cgRectValue().height
                contentCenterYConstraint.priority = 249
            case .showed:
                contentCenterYConstraint.priority = 750
            }
            
            view.setNeedsLayout()
            UIView.animate(
                withDuration: TimeInterval(duration),
                delay: 0,
                options: UIViewAnimationOptions(rawValue: UInt(curve)),
                animations: { [weak self] in
                    self?.view.layoutIfNeeded()
                },
                completion: { (finish) in
                }
            )
            
        }
    }
    
    func keyboardDidShow(notification: Notification) {
        keyboardState = .showed
    }
    
    func keyboardDidHide(notification: Notification) {
        keyboardState = .hidden
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        inputUserName = textField.text.flatMap { $0 + string }
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UserManager.Notif.didLogout, object: nil)
        NotificationCenter.default.removeObserver(self, name: UserManager.Notif.didLogin, object: nil)
    }
}
