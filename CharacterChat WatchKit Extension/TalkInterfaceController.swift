//
//  TalkInterfaceController.swift
//  CharacterChat
//
//  Created by Takuya Yokoyama on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import WatchKit
import Foundation
import SpriteKit
import SceneKit

class TalkInterfaceController: WKInterfaceController, SpeechSynthesizerDelegate {
    
    enum Scene {
        case normal
        case kasige
        
        func create() -> SCNScene? {
            return SCNScene(named: self.filename)
        }
        
        private var filename: String {
            switch self {
            case .normal: return "art.scnassets/default.dae"
            case .kasige: return "art.scnassets/kasige.dae"
            }
        }
    }
    
    @IBOutlet var interfaceScene: WKInterfaceSCNScene!
    private var synthesizer = SpeechSynthesizer()
    private let manager = WatchConnectivityManager.sharedManager
    private var label: SKLabelNode?
    private var chat: Chat?
    
    override func awake(withContext context: AnyObject?) {
        super.awake(withContext: context)
        
        synthesizer.delegate = self
        if let chat = context as? Chat {
            setup(with: chat)
        }
        if let message = chat?.friendLastMessage {
            synthesizer.speech(message: message)
        } else {
            switchScene(scene: .normal)
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    private func setup(with chat: Chat) {
        self.chat = chat
    }
    
    @IBAction func didTappedTalkButton() {
        presentTextInputController(withSuggestions: nil, allowedInputMode: .plain) { [weak self] (results) in
            if let results = results, message = results.first as? String, let id = self?.chat?.friend.identifier {
                self?.present(message: message, dismissOption: (autoDismiss: true, completion: {
                    self?.switchScene(scenes: [.kasige, .normal], interval: 2.0)
                }))
                self?.send(to: id, message: message)
            }
        }
    }
    
    private func send(to userid: String, message: String) {
        manager.send(with: ["post": ["userid": userid, message: message]]) { (result) in
            switch result {
            case .success(let result): break
            case .error(let error): print(error)
            }
        }
    }
    
}

extension TalkInterfaceController {
    func speechSynthesizer(synthesizer: SpeechSynthesizer, didStart speechString: String) {
        present(message: speechString)
    }
    
    func speechSynthesizer(synthesizer: SpeechSynthesizer, didFinish speechString: String) {
        dismissMessage()
        switchScene(scene: .normal)
    }
}

extension TalkInterfaceController {
    private var scene: SCNNode? {
        return interfaceScene.scene?.rootNode
    }
    
    private var object: SCNNode? {
        return getNode(name: "Plane")
    }
    
    private var camera: SCNCamera? {
        let cameraNode = getNode(name: "Camera")
        let camera = cameraNode?.camera
        return camera
    }
    
    private func getNode(name: String) -> SCNNode? {
        return scene?.childNode(withName: name, recursively: true)
    }
    
    private func switchScene(scene: Scene) {
        interfaceScene.scene = scene.create()
    }
    
    private func switchScene(scenes: [Scene], interval: TimeInterval) {
        scenes.enumerated().forEach { (offset, scene) in
            DispatchQueue.main.after(when: .now() + interval * Double(offset), execute: { [weak self] in
                self?.interfaceScene.scene = scene.create()
            })
        }
    }
}

extension TalkInterfaceController {
    typealias DismissOption = (autoDismiss: Bool, completion: ((()->())?))
    
    private func present(message: String, dismissOption: DismissOption? = nil) {
        let label = SKLabelNode(fontNamed: "System")
        self.label = label
        label.horizontalAlignmentMode = .center
        label.text = message
        label.fontSize = 20
        label.fontColor = UIColor.white()
        let x = CGFloat(object?.position.x ?? 0) + (contentFrame.size.width / 2)
        let y = CGFloat(object?.position.y ?? 0) + (contentFrame.size.height / 2)
        label.position = CGPoint(x: x, y: y)
        
        let skScene = SKScene(size: CGSize(width: contentFrame.size.width, height: contentFrame.size.height))
        skScene.scaleMode = SKSceneScaleMode.resizeFill
        skScene.addChild(label)
        
        interfaceScene.overlaySKScene = skScene

        if let option = dismissOption where option.autoDismiss == true {
            dismissMessage(completion: option.completion)
        }
    }
    
//    private func present3DMessage() {
//        let cameraNode = getNode(name: "Camera")
//        
//        let text = SCNText(string: "おはよう", extrusionDepth: 5.0)
//        let textNode = SCNNode(geometry: text)
//        let cameraPosition = cameraNode?.position ?? SCNVector3Zero
//        let cameraZNear = camera?.zNear ?? 0
//        textNode.position = SCNVector3Make(
//            Float(cameraPosition.x - 4),
//            Float(cameraPosition.y - 4),
//            Float(cameraZNear + 5)
//        )
//        textNode.eulerAngles = SCNVector3Make(
//            cameraNode?.eulerAngles.x ?? 0,
//            cameraNode?.eulerAngles.y ?? 0,
//            cameraNode?.eulerAngles.z ?? 0
//        )
//        let scaleValue: Float = 0.4
//        textNode.scale = SCNVector3Make(scaleValue, scaleValue, scaleValue)
//        scene?.addChildNode(textNode)
//    }
    
    private func dismissMessage(completion: (() -> ())? = nil) {
        DispatchQueue.main.after(when: .now() + 2.0) { [weak self] () in
            self?.interfaceScene.overlaySKScene = nil
            if let completion = completion {
                completion()
            }
        }
    }
}
