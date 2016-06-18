//
//  InterfaceController.swift
//  dantimelinson WatchKit Extension
//
//  Created by Henri Watson on 18/06/2016.
//  Copyright © 2016 Henri Watson. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire

class InterfaceController: WKInterfaceController {
    @IBOutlet var currentTime: WKInterfaceDate!
    @IBOutlet var currentDate: WKInterfaceDate!
    @IBOutlet var timezone: WKInterfaceLabel!


    override func awake(withContext context: AnyObject?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        Alamofire.request(.GET, "http://dantimelinson.xyz/?json")
            .responseJSON { response in
                self.timezone.setText(response.result.value!["timeZoneId"] as? String)
                
                let timezone = TimeZone(forSecondsFromGMT: response.result.value!["offset_seconds"] as! Int)
                
                self.currentTime.setTimeZone(timezone)
                
                self.currentDate.setTimeZone(timezone)
                
        }
        
        
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
