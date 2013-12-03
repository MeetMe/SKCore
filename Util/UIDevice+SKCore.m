/*
 * Copyright (c) 2013 MeetMe, Inc. All rights reserved.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#import "UIDevice+SKCore.h"
#import "NSString+SKCore.h"

#import <AddressBook/AddressBook.h>
#import <sys/sysctl.h>
#import <netinet/in.h>

extern CGFloat resolutionIndependentSize(CGFloat pixels)
{
    if ([UIScreen instancesRespondToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0)
    {
        return pixels / 2.0;
    }

    return pixels;
}

NSString *SKPathForResource(NSString *path, NSString *bundle)
{
    NSString *bundlePath = [bundle stringByAppendingPathComponent:path];
    NSString *resourcePath = [NSString stringWithFormat:@"%@", bundlePath];

    static NSString *mainBundlePath = nil;

    if (nil == mainBundlePath)
    {
        mainBundlePath = [NSBundle mainBundle].resourcePath;
    }

    return [mainBundlePath stringByAppendingPathComponent:resourcePath];
}

@implementation UIDevice (ObjectKit)

+ (NSString *)getSysInfoByName:(char *)name
{
    NSString *results = nil;
    size_t size;

    int retVal = sysctlbyname(name, NULL, &size, NULL, 0);
    if (-1 == retVal)
    {
        return results;
    }

    char *sysInfo = malloc(size);
    retVal = sysctlbyname(name, sysInfo, &size, NULL, 0);
    if ( -1 != retVal)
    {
        results = [NSString stringWithCString:sysInfo encoding:NSUTF8StringEncoding];
    }

    free(sysInfo);
    return results;
}

static NSString *systemVersion_ = nil;

+ (NSString *)systemVersion
{
    if (!systemVersion_.isValid)
    {
        systemVersion_ = [[[UIDevice currentDevice] systemVersion] copy];
    }
    return systemVersion_;
}

+ (NSString *)osVersion
{
    return [self getSysInfoByName:"kern.osversion"];
}

+ (NSString *)platform
{
    return [self getSysInfoByName:"hw.machine"];
}

+ (NSString *)platformString
{
    NSDictionary *platformStringDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"iPhone", @"iPhone1,1",
                                        @"iPhone 3G", @"iPhone1,2",
                                        @"iPhone 3GS", @"iPhone2,1",
                                        @"iPhone 4", @"iPhone3,1",
                                        @"iPhone 4 CDMA", @"iPhone3,3",
                                        @"iPhone 4S", @"iPhone4,1",
                                        @"iPhone 5 GSM", @"iPhone5,1",
                                        @"iPhone 5 CDMA", @"iPhone5,2",
                                        @"Unknown iPhone", @"iPhone",
                                        @"iPod Touch 1G", @"iPod1,1",
                                        @"iPod Touch 2G", @"iPod2,1",
                                        @"iPod Touch 3G", @"iPod3,1",
                                        @"iPod Touch 4G", @"iPod4,1",
                                        @"iPod Touch 5G", @"iPod5,1",
                                        @"Unknown iPod", @"iPod",
                                        @"iPad", @"iPad1,1",
                                        @"iPad 2 WiFi", @"iPad2,1",
                                        @"iPad 2 GSM", @"iPad2,2",
                                        @"iPad 2 CDMA", @"iPad2,3",
                                        @"iPad 3rd Gen WiFi", @"iPad3,1",
                                        @"iPad 3rd Gen GSM", @"iPad3,2",
                                        @"iPad 3rd Gen CDMA", @"iPad3,3",
                                        @"iPad 4th Gen WiFi", @"iPad3,4",
                                        @"iPad 4th Gen GSM", @"iPad3,5",
                                        @"iPad 4th Gen CDMA", @"iPad3,6",
                                        @"iPad Mini 1st Gen WiFi", @"iPad2,5",
                                        @"iPad Mini 1st Gen GSM", @"iPad2,6",
                                        @"iPad Mini 1st Gen CDMA", @"iPad2,7",
                                        @"Unknown iPad", @"iPad",
                                        nil];

    NSString *platform = [self platform];
    NSRange prefixRange = [platform rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    NSString *platformPrefix = [platform substringWithRange:NSMakeRange(0, prefixRange.location)];

    if (nil != [platformStringDict objectForKey:platform])
    {
        return [platformStringDict objectForKey:platform];
    }
    else if (nil != [platformStringDict objectForKey:platformPrefix])
    {
        return [platformStringDict objectForKey:platformPrefix];
    }
    else if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])
    {
        return (UIUserInterfaceIdiomPad == [UIDevice currentDevice].userInterfaceIdiom) ? @"iPad Simulator" : @"iPhone Simulator";
    }
    else
    {
        return @"Unknown Device";
    }
}

+ (NSString *)deviceIdentifier
{
    NSString *currentUUID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"MYBUUID"] copy];
    if (currentUUID == nil)
    {
        CFUUIDRef deviceUUID = CFUUIDCreate(NULL);
        currentUUID = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, deviceUUID);
        CFRelease(deviceUUID);

        [[NSUserDefaults standardUserDefaults] setObject:currentUUID forKey:@"MYBUUID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    return currentUUID;
}

+ (BOOL)getReachabilityFlags:(SCNetworkReachabilityFlags *)flags
{
    if (NULL == flags)
    {
        return NO;
    }

    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;

    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault,
                                                                                      (const struct sockaddr *)&zeroAddress);
    if (NULL == reachabilityRef)
    {
        return NO;
    }

    if (!SCNetworkReachabilityGetFlags(reachabilityRef, flags))
    {
        CFRelease(reachabilityRef);
        return NO;
    }

    // Logging left here for future debugging
//    NSLog(@"Reachability Flag Status: %c%c %c%c%c%c%c%c%c\n",
//          (*flags & kSCNetworkReachabilityFlagsIsWWAN)               ? 'W' : '-',
//          (*flags & kSCNetworkReachabilityFlagsReachable)            ? 'R' : '-',
//          (*flags & kSCNetworkReachabilityFlagsTransientConnection)  ? 't' : '-',
//          (*flags & kSCNetworkReachabilityFlagsConnectionRequired)   ? 'c' : '-',
//          (*flags & kSCNetworkReachabilityFlagsConnectionOnTraffic)  ? 'C' : '-',
//          (*flags & kSCNetworkReachabilityFlagsInterventionRequired) ? 'i' : '-',
//          (*flags & kSCNetworkReachabilityFlagsConnectionOnDemand)   ? 'D' : '-',
//          (*flags & kSCNetworkReachabilityFlagsIsLocalAddress)       ? 'l' : '-',
//          (*flags & kSCNetworkReachabilityFlagsIsDirect)             ? 'd' : '-'
//          );

    CFRelease(reachabilityRef);
    return YES;
}

+ (BOOL)hasWiFiConnection
{
    SCNetworkReachabilityFlags flags;
    if (![self getReachabilityFlags:&flags])
    {
        return NO;
    }

    if (0 == (flags & kSCNetworkReachabilityFlagsReachable))
    {
        // Target host is not reachable
        return NO;
    }

    BOOL retVal = NO;

    if (0 == (flags & kSCNetworkReachabilityFlagsConnectionRequired))
    {
        // If target host is reachable and no connection is required
        // then we'll assume (for now) that you're on Wi-Fi
        retVal = YES;
    }

    if ((0 != (flags & kSCNetworkReachabilityFlagsConnectionOnDemand)) ||
        (0 != (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic)))
    {
        // If the connection is on-demand (or on-traffic) if the
        // calling application is using the CFSocketStream or higher APIs

        if (0 == (flags & kSCNetworkReachabilityFlagsInterventionRequired))
        {
            // and no [user] intervention is needed
            retVal = YES;
        }
    }

    if (0 != (flags & kSCNetworkReachabilityFlagsIsWWAN))
    {
        // Since this is valid only for WWAN, the WiFi
        // connection isn't actually up.
        retVal = NO;
    }

    return retVal;
}

+ (BOOL)hasWWANConnection
{
    SCNetworkReachabilityFlags flags;
    if (![self getReachabilityFlags:&flags])
    {
        return NO;
    }

    if (0 != (flags & kSCNetworkReachabilityFlagsReachable) &&
        0 != (flags & kSCNetworkReachabilityFlagsIsWWAN))
    {
        // Target host is reachable and is over WWAN
        return YES;
    }

    return NO;
}

+ (BOOL)iOS6Plus
{
    return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0");
}

+ (BOOL)iOS7Plus
{
    return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0");
}

+ (BOOL)hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL)isJailbroken
{
#if TARGET_IPHONE_SIMULATOR
    return NO;
#endif

    NSArray *apps = [NSArray arrayWithObjects:
                     @"/bin/bash",
                     @"/Applications/Cydia.app",
                     @"/Applications/limera1n.app",
                     @"/Applications/greenpois0n.app",
                     @"/Applications/blackra1n.app",
                     @"/Applications/blacksn0w.app",
                     @"/Applications/redsn0w.app",
                     nil];

    // Check for known jailbreak apps. If we encounter one, the device is jailbroken.
    for (NSString *path in apps)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            return YES;
        }
    }

    return NO;
}

+ (BOOL)isPad
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+ (BOOL)isRetina4_5Inch
{
    BOOL isTall = [UIScreen mainScreen].bounds.size.height == 568.0f;
    BOOL isRetina = [UIScreen mainScreen].scale == 2.f;
    BOOL isPhoneOrPod = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;

    return (isTall && isRetina && isPhoneOrPod);
}

@end
