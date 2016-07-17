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
import AVFoundation

class TalkInterfaceController: WKInterfaceController, AVSpeechSynthesizerDelegate {
    
    @IBOutlet var interfaceScene: WKInterfaceSCNScene!
    private let synthesizer = AVSpeechSynthesizer()
    private var label: SKLabelNode?
    
    private var scene: SCNNode? {
        return interfaceScene.scene?.rootNode
    }
    
    private var object: SCNNode? {
        return scene?.childNode(withName: "Plane", recursively: true)
    }
    
    private var camera: SCNCamera? {
        let cameraNode = scene?.childNode(withName: "Camera", recursively: true)
        let camera = cameraNode?.camera
        return camera
    }
    
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
//        let text = SCNText(string: "TEST", extrusionDepth: 0.0)
//        let textNode = SCNNode(geometry: text)
//        let x = Float(object?.position.x ?? 0)
//        let y = Float(object?.position.y ?? 0)
//        let z = Float(camera?.zNear ?? 0)
//        textNode.position = SCNVector3Make(x, y, z)
//        scene?.addChildNode(textNode)
    }
    
    private func run() {
        speech(message: "おはよう")
    }
    
    @IBAction func didTappedTalkButton() {
        presentTextInputController(withSuggestions: nil, allowedInputMode: .plain) { [weak self] (results) in
            if let results = results, message = results.first as? String {
                self?.send(to: "Arisa", message: message)
            }
        }
    }
    
    private func send(to user: String, message: String) {
        //        speech(message: message)
    }
    
    private func speech(message: String) {
        synthesizer.delegate = self
        let utterance =  AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        utterance.rate = 0.55
        utterance.volume = 1
        synthesizer.speak(utterance)
    }
    
    private func presentMessage() {
        let label = SKLabelNode(fontNamed: "System")
        self.label = label
        label.horizontalAlignmentMode = .center
        label.text = "おはよう"
        label.fontSize = 20
        label.fontColor = UIColor.white()
        let x = CGFloat(object?.position.x ?? 0) + (contentFrame.size.width / 2)
        let y = CGFloat(object?.position.y ?? 0) + (contentFrame.size.height / 2)
        label.position = CGPoint(x: x, y: y)
        
        let skScene = SKScene(size: CGSize(width: contentFrame.size.width, height: contentFrame.size.height))
        skScene.scaleMode = SKSceneScaleMode.resizeFill
        skScene.addChild(label)
        
        interfaceScene.overlaySKScene = skScene
    }
    
    private func dismissMessage() {
        DispatchQueue.main.after(when: .now() + 2.0) { [weak self] () in
            self?.interfaceScene.overlaySKScene = nil
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        presentMessage()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        dismissMessage()
    }
    
    
}
