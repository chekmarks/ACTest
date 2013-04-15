

// Basic action
typedef void (^Block)();

// Signature for NSNotificationCenter observing
typedef void (^NotificationBlock)(NSNotification*);

// Signature for NSURLConnection completion handler
typedef void (^CompletionHandler)(NSURLResponse*, NSData*, NSError*);