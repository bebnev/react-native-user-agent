
#import <sys/utsname.h>

#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

@interface RNUserAgent : NSObject <RCTBridgeModule>
@end
