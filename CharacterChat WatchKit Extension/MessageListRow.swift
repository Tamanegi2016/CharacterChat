//
//  MessageListRow.swift
//  CharacterChat
//
//  Created by Takuya Yokoyama on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import WatchKit

class MessageListRow: NSObject {
    
    @IBOutlet var image: WKInterfaceImage!
    @IBOutlet var name: WKInterfaceLabel!
    @IBOutlet var message: WKInterfaceLabel!
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func configure(chat: Chat) {
        loadImage(imageurl: chat.friend.profileImage)
        name.setText(chat.friend.name)
        message.setText(chat.message.last?.content ?? "")
    }
    
    private func loadImage(imageurl: URL) {
        let task = session.dataTask(with: imageurl) { (data, response, error) in
            DispatchQueue.main.async{
                if let data = data {
                    self.image.setImageData(data)
                }
            }
        }
        task.resume()
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: chat.friend.profileImage) {
//                DispatchQueue.main.async{
//                    self.image.setImageData(data)
//                }
//            }
//        }
    }
}
