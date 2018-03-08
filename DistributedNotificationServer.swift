//
//  ServerMachPort.swift
//  SampleAppCheckout
//
//  Created by N.A Shashank on 06/03/18.
//  Copyright © 2018 Abhinav. All rights reserved.
//

import Foundation

final class DistributedNotificationServer {
    
    func postNotification(name:String) {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFNotificationName.init(rawValue: name as CFString), nil, nil, true)
    }
    
}
