//
//  ChatDetailContainerViewController.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/16.
//  Copyright © 2016年 Kazuhiro Hayashi All rights reserved.
//

import UIKit

class ChatDetailContainerViewController: UIViewController, UITextViewDelegate {

    
    var tableVC: ChatDetailTableViewController?
    
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var inputContainerViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputTextViewHeightConstaraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(ChatDetailContainerViewController.keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatDetailContainerViewController.keyboardDidHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatDetailContainerViewController.keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ChatDetailContainerViewController.didTapView(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableVC?.tableView.contentInset.bottom = inputContainerView.bounds.height + bottomLayoutGuide.length
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? ChatDetailTableViewController {
            tableVC = vc
        }
    }
    
    enum KeyboardState {
        case showed
        case willHide
        case hidden
    }
    
    var keyboardState: KeyboardState = .hidden
    
    func keyboardWillChange(notification: Notification) {
        if let value = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? CGFloat,
            curve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? CGFloat {
    
            switch keyboardState {
            case .hidden, .showed:
                inputContainerViewBottomConstraint.constant = value.cgRectValue().height - bottomLayoutGuide.length
                tableContainerViewBottomConstraint.constant = value.cgRectValue().height - inputContainerView.frame.height
            case .willHide:
                inputContainerViewBottomConstraint.constant = 0
                tableContainerViewBottomConstraint.constant = inputContainerView.frame.height
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
    
    @IBAction func didTapSendButton(_ sender: UIButton) {
        let message = inputTextView.text
        
        UserManager.sharedInstance.message(to: "6", content: message!) { (success) in
            
        }
        keyboardState = .willHide
        inputTextView.resignFirstResponder()
        inputTextView.text = nil
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        inputTextViewHeightConstaraint.constant = min(78, textView.contentSize.height)
    }
    
    func didTapView(_ gesture: UITapGestureRecognizer) {
        if keyboardState == .showed {
            keyboardState = .willHide
            inputTextView.resignFirstResponder()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UserManager.Notif.didLogout, object: nil)
        NotificationCenter.default.removeObserver(self, name: UserManager.Notif.didLogin, object: nil)
    }
}
