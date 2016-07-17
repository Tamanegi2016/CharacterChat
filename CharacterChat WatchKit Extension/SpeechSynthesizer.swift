//
//  SpeechSynthesizer.swift
//  CharacterChat
//
//  Created by Takuya Yokoyama on 2016/07/17.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import Foundation
import AVFoundation

protocol SpeechSynthesizerDelegate: class {
    func speechSynthesizer(synthesizer: SpeechSynthesizer, didStart speechString: String)
    func speechSynthesizer(synthesizer: SpeechSynthesizer, didFinish speechString: String)
}

class SpeechSynthesizer: NSObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    weak var delegate: SpeechSynthesizerDelegate?
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    func speech(message: String) {
        let utterance =  AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        utterance.rate = 0.4
        utterance.volume = 1
        synthesizer.speak(utterance)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        delegate?.speechSynthesizer(synthesizer: self, didStart: utterance.speechString)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        delegate?.speechSynthesizer(synthesizer: self, didFinish: utterance.speechString)
    }
}
