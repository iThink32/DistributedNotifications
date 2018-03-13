//
//  DistributedNotificationsObserver.swift
//
//  Created by N.A Shashank on 08/03/18.
//

import UIKit

public final class DistributedNotificationObserver{
    
    public class func addObserver(name:String,observer:UIViewController,callBack:@escaping CFNotificationCallback) {
        let observer = UnsafeRawPointer(Unmanaged.passUnretained(observer).toOpaque())
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), observer, callBack, name as CFString, nil, CFNotificationSuspensionBehavior.deliverImmediately)
    }
    
    public class func removeObservers(observer:UIViewController,name:String) {
            let observer = Unmanaged.passUnretained(observer).toOpaque()
            let name = CFNotificationName.init(name as CFString)
            CFNotificationCenterRemoveObserver(CFNotificationCenterGetDarwinNotifyCenter(), observer,name, nil)
    }
    
}
