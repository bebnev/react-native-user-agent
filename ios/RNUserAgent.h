
#import <sys/utsname.h>
#import <UIKit/UIKit.h>

#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

@interface RNUserAgent : NSObject <RCTBridgeModule>
@property (nonatomic) bool isEmulator;
@end
