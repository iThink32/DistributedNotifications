# DistributedNotifications
## A Repo that lets you post notifications across multiple applications or processes on the same device

### This method is used for communication between different processes or applications , do not use it for local communication !

### this readme follows the client server architecture if you want bi-directional communication please use DarwinNotificationCenter and look at TwoWayCommunication.md for how to.

#### Usage:-
First identify which class is your server and which class is your listener.

Setup your server like so:-

```
var server = DistributedNotificationServer()
```
and then post a notification whereever required like 

```
self.server.postNotification(name: TestNotificationConstants.paymentScreenViewed.stringValue())
```

Now client side is a little complex

You add an observer and its associated callback as so

```
    func addObservers() {
            DistributedNotificationObserver.addObserver(name: TestNotificationConstants.paymentScreenViewed.stringValue(),
               observer: self, callBack: self.paymentScreenViewed())
    }
    
    func paymentScreenViewed() -> CFNotificationCallback {
        return {  (center,observer,name,object,info) in
            
            guard let unwrappedObserver = observer else{
                return
            }
            let instance = Unmanaged<ViewController>.fromOpaque(unwrappedObserver).takeUnretainedValue()
        }
    }
```

Now whats happening here is that you add an observer but it takes a callBack and this callback must be a function reference
that returns a CFNotificationCallBack, thats why there is another function called paymentScreenViewed() whose reference is 
passed.

Now this part:-
```
            guard let unwrappedObserver = observer else{
                return
            }
            let instance = Unmanaged<ViewController>.fromOpaque(unwrappedObserver).takeUnretainedValue()
            instance.anyInstanceMethod() // anyInstanceMethod is any method of the class ViewController or ideally
            observer added.
```
To understand this well you need to read about how swift manages non ARC pointers or in short UnsafePointers but all i can say
now is this is a funcation that returns a C callBack which does not capture self so you cannot call anything related to self.
To fix this we cast self as an UnsafeRawPointer and add it as an observer and in the callback recast it back to our
ViewController.

Complex? This is nothing in front of the hell ive been through to put forward this to you :p

So in short do the above and your callback will be called.

#### NOTE:- VERY VERY IMP

In the case of these notifications i.e Darwin the userInfo , object and deliverImmediately is ignored by iOS that means 
YOU CANNOT SEND DATA VIA THESE NOTIFICATIONS.

check this link for reference :-
https://developer.apple.com/documentation/corefoundation/1542592-cfnotificationcenterpostnotifica?language=objc 

