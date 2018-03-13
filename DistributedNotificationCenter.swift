//
//  DistributedNotificationsObserver.swift
//
//  Created by N.A Shashank on 08/03/18.
//

import UIKit

public final class DistributedNotificationCenter{
    
    public class func registerObservers(arrNotificationName:[String],observer:AnyObject) {
        let observer = UnsafeRawPointer(Unmanaged.passUnretained(observer).toOpaque())
        arrNotificationName.forEach { (name) in
            CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), observer, DistributedNotificationCenter.callBack(),name as CFString,nil, CFNotificationSuspensionBehavior.deliverImmediately)
        }
    }
    
    private class func callBack() -> CFNotificationCallback {
        return { (center,observer,name,object,userInfo) in
            guard let unwrappedName = name else{
                return
            }
            NotificationCenter.default.post(name: NSNotification.Name(String(describing: unwrappedName.rawValue)), object: nil)
        }
    }
    
    
    class func removeObservers(observer:UIViewController) {
        let observer = UnsafeRawPointer(Unmanaged.passUnretained(observer).toOpaque())
        CFNotificationCenterRemoveEveryObserver(CFNotificationCenterGetDarwinNotifyCenter(), observer)
    }
    
    class func postNotification(name:String) {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFNotificationName.init(rawValue: name as CFString), nil, nil, true)
    }
    
    
}
