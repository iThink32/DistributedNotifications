# Two Way Communication usign DarwinNotificationCenter
#### Please note that this is not meant for chat purposes , it has a system overhead and should be used with caution.Please use it when there is no other way of inter-process/inter-application communication.

## Usage:-

You first have to register for notifications as follows:-

```
 DistributedNotificationCenter.registerObservers(arrNotificationName: ["name1","name2"], observer: self)
 NotificationCenter.default.addObserver(self, selector: #selector(choosePaymentMethod), name:
 NSNotification.Name(rawValue:"name1"), object: nil)
 NotificationCenter.default.addObserver(self, selector: #selector(choosePaymentMethod), name:
 NSNotification.Name(rawValue:"name2"), object: nil)
```

You have to register with Notification Center as i am internally receiving darwin notifications and posting them
as local notifications so that you can set your selector accordingly.I also felt its a little more decoupled.

after this you can use your respective selectors to perform whatever you want to.

To post a Notication it is very simple 

```
DistributedNotificationCenter.postNotification(name: "name1")
```

but remember when you post a notification the class that has to receive it must register and listen to it as mentioned above.

### Darwin notifications cannot be used with a user-info dict it is automatically ignored by iOS.It is strictly meant for     notifications.
