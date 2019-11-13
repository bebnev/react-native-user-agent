//
//  UserAgent.m
//  lkfl
//
//  Created by Anton Bebnev on 05.07.2018.
#import "RNUserAgent.h"
#if !(TARGET_OS_TV)
#import <WebKit/WebKit.h>
#endif

@implementation RNUserAgent
{
    #if !(TARGET_OS_TV)
        WKWebView *webView;
    #endif
}

RCT_EXPORT_MODULE(RNUserAgent);

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

//eg. Darwin/16.3.0
- (NSString *)getDarwinVersion
{
    struct utsname u;
    (void) uname(&u);
    return [NSString stringWithUTF8String:u.release];
}

//eg. iPhone 11 Pro Max
- (NSString *)getModel
{
    struct utsname systemInfo;
    uname(&systemInfo);

    NSString* deviceId = [NSString stringWithUTF8String:systemInfo.machine];

    if ([deviceId isEqualToString:@"i386"] || [deviceId isEqualToString:@"x86_64"] ) {
        deviceId = [NSString stringWithFormat:@"%s", getenv("SIMULATOR_MODEL_IDENTIFIER")];
    }

    static NSDictionary* deviceNames = nil;

    if (!deviceNames) {

        deviceNames = @{@"iPad1,1"   :@"iPad",            // (Original)
                              @"iPad2,1"   :@"iPad/2",
                              @"iPad2,2"   :@"iPad/2",
                              @"iPad2,3"   :@"iPad/2",
                              @"iPad2,4"   :@"iPad/2",
                              @"iPad3,1"   :@"iPad",            // (3rd Generation)
                              @"iPad3,2"   :@"iPad",            // (3rd Generation)
                              @"iPad3,3"   :@"iPad",            // (3rd Generation)
                              @"iPad3,4"   :@"iPad",            // (4th Generation)
                              @"iPad3,5"   :@"iPad",            // (4th Generation)
                              @"iPad3,6"   :@"iPad",            // (4th Generation)
                              @"iPad2,5"   :@"iPad/Mini",       // (Original)
                              @"iPad2,6"   :@"iPad/Mini",       // (Original)
                              @"iPad2,7"   :@"iPad/Mini",       // (Original)
                              @"iPad4,1"   :@"iPad/Air",        // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad/Air",        // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,3"   :@"iPad/Air",        // 5th Generation iPad (iPad Air)
                              @"iPad4,4"   :@"iPad/Mini_2",     // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad/Mini_2",     // (2nd Generation iPad Mini - Cellular)
                              @"iPad4,6"   :@"iPad/Mini_2",     // (2nd Generation iPad Mini)
                              @"iPad4,7"   :@"iPad/Mini_3",     // (3rd Generation iPad Mini)
                              @"iPad4,8"   :@"iPad/Mini_3",     // (3rd Generation iPad Mini)
                              @"iPad4,9"   :@"iPad/Mini_3",     // (3rd Generation iPad Mini)
                              @"iPad5,1"   :@"iPad/Mini_4",     // (4th Generation iPad Mini)
                              @"iPad5,2"   :@"iPad/Mini_4",     // (4th Generation iPad Mini)
                              @"iPad5,3"   :@"iPad/Air_2",      // 6th Generation iPad (iPad/Air_2)
                              @"iPad5,4"   :@"iPad/Air_2",      // 6th Generation iPad (iPad/Air_2)
                              @"iPad6,3"   :@"iPad/Pro_9.7-inch",// iPad/Pro_9.7-inch
                              @"iPad6,4"   :@"iPad/Pro_9.7-inch",// iPad/Pro_9.7-inch
                              @"iPad6,7"   :@"iPad/Pro_12.9-inch",// iPad/Pro_12.9-inch
                              @"iPad6,8"   :@"iPad/Pro_12.9-inch",// iPad/Pro_12.9-inch
                              @"iPad7,1"   :@"iPad/Pro_12.9-inch",// 2nd Generation iPad Pro 12.5-inch - Wifi
                              @"iPad7,2"   :@"iPad/Pro_12.9-inch",// 2nd Generation iPad Pro 12.5-inch - Cellular
                              @"iPad7,3"   :@"iPad/Pro_10.5-inch",// iPad/Pro_10.5-inch - Wifi
                              @"iPad7,4"   :@"iPad/Pro_10.5-inch",// iPad/Pro_10.5-inch - Cellular
                              @"iPad7,5": @"iPad (6th generation)", // iPad (6th generation) - Wifi
                              @"iPad7,6": @"iPad (6th generation)", // iPad (6th generation) - Cellular
                              @"iPad7,11": @"iPad (7th generation)", // iPad 10.2 inch (7th generation) - Wifi
                              @"iPad7,12": @"iPad (7th generation)", // iPad 10.2 inch (7th generation) - Wifi + cellular
                              @"iPad8,1": @"iPad Pro 11-inch (3rd generation)", // iPad Pro 11 inch (3rd generation) - Wifi
                              @"iPad8,2": @"iPad Pro 11-inch (3rd generation)", // iPad Pro 11 inch (3rd generation) - 1TB - Wifi
                              @"iPad8,3": @"iPad Pro 11-inch (3rd generation)", // iPad Pro 11 inch (3rd generation) - Wifi + cellular
                              @"iPad8,4": @"iPad Pro 11-inch (3rd generation)", // iPad Pro 11 inch (3rd generation) - 1TB - Wifi + cellular
                              @"iPad8,5": @"iPad Pro 12.9-inch (3rd generation)", // iPad Pro 12.9 inch (3rd generation) - Wifi
                              @"iPad8,6": @"iPad Pro 12.9-inch (3rd generation)", // iPad Pro 12.9 inch (3rd generation) - 1TB - Wifi
                              @"iPad8,7": @"iPad Pro 12.9-inch (3rd generation)", // iPad Pro 12.9 inch (3rd generation) - Wifi + cellular
                              @"iPad8,8": @"iPad Pro 12.9-inch (3rd generation)", // iPad Pro 12.9 inch (3rd generation) - 1TB - Wifi + cellular
                              @"iPad11,1": @"iPad Mini 5", // (5th Generation iPad Mini)
                              @"iPad11,2": @"iPad Mini 5", // (5th Generation iPad Mini)
                              @"iPad11,3": @"iPad Air (3rd generation)",
                              @"iPad11,4": @"iPad Air (3rd generation)",
                              @"iPhone1,1" :@"iPhone",          // (Original)
                              @"iPhone1,2" :@"iPhone/3G",       // (3G)
                              @"iPhone2,1" :@"iPhone/3GS",      // (3GS)
                              @"iPhone3,1" :@"iPhone/4",        // (GSM)
                              @"iPhone3,2" :@"iPhone/4",        // iPhone 4
                              @"iPhone3,3" :@"iPhone/4",        // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone/4S",       //
                              @"iPhone5,1" :@"iPhone/5",        // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone/5",        // (model A1429, everything else)
                              @"iPhone5,3" :@"iPhone/5c",       // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone/5c",       // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone/5s",       // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone/5s",       // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone/6_Plus",
                              @"iPhone7,2" :@"iPhone/6",
                              @"iPhone8,1" :@"iPhone/6s",
                              @"iPhone8,2" :@"iPhone/6s_Plus",
                              @"iPhone8,4" :@"iPhone/SE",
                              @"iPhone9,1" :@"iPhone/7",        // (model A1660 | CDMA)
                              @"iPhone9,3" :@"iPhone/7",        // (model A1778 | Global)
                              @"iPhone9,2" :@"iPhone/7_Plus",   // (model A1661 | CDMA)
                              @"iPhone9,4" :@"iPhone/7_Plus",   // (model A1784 | Global)
                              @"iPhone10,1":@"iPhone/8",        // (model A1863, A1906, A1907)
                              @"iPhone10,2":@"iPhone/8_Plus",   // (model A1864, A1898, A1899)
                              @"iPhone10,3":@"iPhone/X",        // (model A1865, A1902)
                              @"iPhone10,4":@"iPhone/8",        // (model A1905)
                              @"iPhone10,5":@"iPhone/8_Plus",   // (model A1897)
                              @"iPhone10,6":@"iPhone/X",        // (model A1901)
                              @"iPhone11,2": @"iPhone XS", // (model A2097, A2098)
                              @"iPhone11,4": @"iPhone XS Max", // (model A1921, A2103)
                              @"iPhone11,6": @"iPhone XS Max", // (model A2104)
                              @"iPhone11,8": @"iPhone XR", // (model A1882, A1719, A2105)
                              @"iPhone12,1": @"iPhone 11",
                              @"iPhone12,3": @"iPhone 11 Pro",
                              @"iPhone12,5": @"iPhone 11 Pro Max",
                              @"AppleTV2,1":@"AppleTV",        // Apple TV (2nd Generation)
                              @"AppleTV3,1":@"AppleTV",        // Apple TV (3rd Generation)
                              @"AppleTV3,2":@"AppleTV",        // Apple TV (3rd Generation - Rev A)
                              @"AppleTV5,3":@"AppleTV",        // Apple TV (4th Generation)
                              @"AppleTV6,2":@"AppleTV_4K",     // Apple TV 4K
                              };
    }

     NSString* deviceName = [deviceNames valueForKey:deviceId];

     if (deviceName) {
         return deviceName;
     }

    if([deviceId hasPrefix:@"iPad"]) {
        return @"iPad";
    }
    else if([deviceId hasPrefix:@"iPhone"]){
        return @"iPhone";
    }
    else if([deviceId hasPrefix:@"AppleTV"]){
        return @"AppleTV";
    }

    return @"unknown";
}


- (NSString *)getAppName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"] ?: [NSNull null];
}

- (NSString *)getAppVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] ?: [NSNull null];
}

- (NSString *)getBuildNumber
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] ?: [NSNull null];
}

- (NSString *)getCfnVersion
{
    return [NSBundle bundleWithIdentifier:@"com.apple.CFNetwork"].infoDictionary[@"CFBundleShortVersionString"];
}

RCT_EXPORT_METHOD(getWebViewUserAgent:(RCTPromiseResolveBlock) resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    #if TARGET_OS_TV
        reject(@"not_available_error", @"not available on tvOS", nil);
    #else
    __weak RNUserAgent *weakSelf = self;
    //__block WKWebView* webView = [[WKWebView alloc] init];
    dispatch_async(
        dispatch_get_main_queue(), ^{
            __strong RNUserAgent *strongSelf = weakSelf;

            if (strongSelf) {
                strongSelf->webView = [[WKWebView alloc] init];

                [strongSelf->webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                    if (error) {
                        reject(@"getWebViewUserAgentError", error.localizedDescription, error);
                        return;
                    }

                    resolve([NSString stringWithFormat:@"%@", result]);
                    strongSelf->webView = nil;
                }];
            }
        }
    );
#endif
}

- (NSDictionary *)constantsToExport
{
    UIDevice *currentDevice = [UIDevice currentDevice];

    NSString* appName = [self getAppName];
    NSString* appVersion = [self getAppVersion];
    NSString* buildNumber = [self getBuildNumber];
    NSString* darwinVersion = [self getDarwinVersion];
    NSString* cfnVersion = [self getCfnVersion];
    NSString* modelName = [self getModel];

    return @{
         @"systemName": currentDevice.systemName,
         @"systemVersion": currentDevice.systemVersion,
         @"applicationName": appName,
         @"applicationVersion": appVersion,
         @"buildNumber": buildNumber,
         @"darwinVersion": darwinVersion,
         @"cfnetworkVersion": cfnVersion,
         @"deviceName": modelName, //@deprecated
         @"modelName": modelName,
         @"userAgent": [NSString stringWithFormat:@"%@/%@.%@ CFNetwork/%@ Darwin/%@ (%@ %@/%@)", appName, appVersion, buildNumber, cfnVersion, darwinVersion, modelName, currentDevice.systemName, currentDevice.systemVersion]
    };
}

@end
