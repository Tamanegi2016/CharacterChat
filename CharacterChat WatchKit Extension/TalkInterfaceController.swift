//
//  TalkInterfaceController.swift
//  CharacterChat
//
//  Created by Takuya Yokoyama on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import WatchKit
import Foundation

class TalkInterfaceController: WKInterfaceController {
    
    @IBOutlet var interfaceScene: WKInterfaceSCNScene!
    
    override func awake(withContext context: AnyObject?) {
        super.awake(withContext: context)
        setup()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        run()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func setup() {
        
    }
    
    private func run() {
        guard let sceneRoot = interfaceScene.scene?.rootNode else { return }
        if let soundSource = SCNAudioSource(named: "art.scnassets/amuro.mp3") {
            let sequece = SCNAction.sequence([
                SCNAction.wait(forDuration: 1.0),
                SCNAction.play(soundSource, waitForCompletion: false)
                ])
            sceneRoot.run(sequece)
        }
    }
    
    @IBAction func didTappedTalkButton() {
        presentTextInputController(withSuggestions: nil, allowedInputMode: .plain) { [weak self] (results) in
            if let results = results, message = results.first as? String {
                self?.send(to: "Arisa", message: message)
            }
        }
    }
    
    private func presentConfirmAlert(with title: String?, message: String?) {
        let confirmAction = WKAlertAction(title: "OK", style: .default) {
        }
        presentAlert(withTitle: title, message: message, preferredStyle: .alert, actions: [confirmAction])
    }
    
    private func send(to user: String, message: String) {
        presentConfirmAlert(with: nil, message: message)
    }
    
}
