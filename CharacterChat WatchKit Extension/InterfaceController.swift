//
//  InterfaceController.swift
//  CharacterChat WatchKit Extension
//
//  Created by Takuya Yokoyama on 2016/07/16.
//  Copyright © 2016年 Yahoo Japan Corporation. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var table: WKInterfaceTable!
    
    override func awake(withContext context: AnyObject?) {
        super.awake(withContext: context)
        
        loadTable()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func loadTable() {
        table.setNumberOfRows(3, withRowType: "MessageListRow")
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        super.table(table, didSelectRowAt: rowIndex)
    }

}
