//
//  CharacterSelectViewController.swift
//  CharacterChat
//
//  Created by 林　和弘 on 2016/07/17.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import UIKit
import SceneKit

// TODO:- 開発用試し
var profileImage: UIImage?

class CharacterSelectViewController: UIViewController {

    
    @IBOutlet weak var characterPreviewView: SCNView!
    var selectVC: CharacterPartsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene =  SCNScene()
        let nodeCamera = SCNNode()
        nodeCamera.camera = SCNCamera()
        scene.rootNode.addChildNode(nodeCamera)
        nodeCamera.position = SCNVector3(x: 0, y: 0, z: 30)
        
        let nodeLight = SCNNode()
        nodeLight.light = SCNLight()
        nodeLight.light!.type = SCNLightTypeOmni
        nodeLight.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(nodeLight)
        
        let nodeAmbiendLight = SCNNode()
        nodeAmbiendLight.light = SCNLight()
        nodeAmbiendLight.light!.type = SCNLightTypeAmbient
        nodeAmbiendLight.light!.color = UIColor.lightGray().cgColor
        scene.rootNode.addChildNode(nodeAmbiendLight)

        let secondScene = SCNScene(named: "test.dae")
        let node = secondScene?.rootNode.childNode(withName: "Plane", recursively: true)
        scene.rootNode.addChildNode(node!)
        
        characterPreviewView.scene = scene
        characterPreviewView.allowsCameraControl = true
        characterPreviewView.backgroundColor = .white()
        
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? CharacterPartsViewController {
            selectVC = vc
        }
    }
    
    @IBAction func didTapCloseButton(_ sender: UIBarButtonItem) {
        UIGraphicsBeginImageContextWithOptions(characterPreviewView.frame.size, false, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        profileImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        dismiss(animated: true, completion: nil)
    }
}
