//
//  UserAgent.m
//  lkfl
//
//  Created by Anton Bebnev on 05.07.2018.
#import "RNUserAgent.h"

@implementation RNUserAgent

RCT_EXPORT_MODULE(RNUserAgent);

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

//eg. Darwin/16.3.0
- (NSString *)darwinVersion
{
    struct utsname u;
    (void) uname(&u);
    return [NSString stringWithUTF8String:u.release];
}

//eg. iPhone5,2
- (NSString *)deviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithUTF8String:systemInfo.machine];
}

- (NSString *)getWebViewUserAgent
{
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    return [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
}


- (NSDictionary *)constantsToExport
{
    UIDevice *currentDevice = [UIDevice currentDevice];
    
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"] ?: [NSNull null];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] ?: [NSNull null];
    NSString *buildNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] ?: [NSNull null];
    NSString *darwinVersion = [self darwinVersion];
    NSString *cfnVersion = [NSBundle bundleWithIdentifier:@"com.apple.CFNetwork"].infoDictionary[@"CFBundleShortVersionString"];
    NSString *deviceName = [self deviceName];
    
    return @{
             @"systemName": currentDevice.systemName,
             @"systemVersion": currentDevice.systemVersion,
             @"applicationName": appName,
             @"applicationVersion": appVersion,
             @"buildNumber": buildNumber,
             @"darwinVersion": darwinVersion,
             @"cfnetworkVersion": cfnVersion,
             @"userAgent": [NSString stringWithFormat:@"%@/%@.%@ CFNetwork/%@ Darwin/%@ (%@ %@/%@)", appName, appVersion, buildNumber, cfnVersion, darwinVersion, deviceName, currentDevice.systemName, currentDevice.systemVersion],
             @"webViewUserAgent": self.getWebViewUserAgent ?: [NSNull null]
             };
}

@end
