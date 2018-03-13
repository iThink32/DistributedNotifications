//
//  ServerMachPort.swift
//
//  Created by N.A Shashank on 06/03/18.
//

import Foundation

final class DistributedNotificationServer {
    
    func postNotification(name:String) {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFNotificationName.init(rawValue: name as CFString), nil, nil, true)
    }
    
}
