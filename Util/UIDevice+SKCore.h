/**
 * Copyright (c) 2013 MeetMe, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the MeetMe inc. nor the
 * names of its contributors may be used to endorse or promote products
 * derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL MeetMe inc. BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <SystemConfiguration/SystemConfiguration.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[UIDevice systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[UIDevice systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[UIDevice systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[UIDevice systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[UIDevice systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//! Access a bundle resource.
NSString *SKPathForResource(NSString *path, NSString *bundle);

/**
 * Used to get a resolution independed size.
 *
 * @param pixels Number of pixels to get the size for.
 * @return The size of the pixels.
 */
extern CGFloat resolutionIndependentSize(CGFloat pixels);

/**
 * Collection of common methods to get information about the current device.
 *
 * @author Joseph Szymanski
 */
@interface UIDevice (SKCore)

/**
 * Method used to allow access to hardware information.
 *
 * @param name The key for the info needed e.g. "kern.osversion"
 * @return the string value for the key.
 */
+ (NSString *)getSysInfoByName:(char *)name;

//! Get the system version of the current device.
+ (NSString *)systemVersion;

//! Get the OS version of the current device.
+ (NSString *)osVersion;

//! Get the platform of the current device.
+ (NSString *)platform;

//! Get the platform of the current device as a string.
+ (NSString *)platformString;

//! The unique identifier for the current device.
+ (NSString *)deviceIdentifier;

/**
 * Pulls a set of flags that indicate network state.
 *
 * @param flags Gets populated with the flags available.
 * @return YES if successful.
 */
+ (BOOL)getReachabilityFlags:(SCNetworkReachabilityFlags *)flags;

//! Do we have wifi access?
+ (BOOL)hasWiFiConnection;

//! Do we have WWAN access?
+ (BOOL)hasWWANConnection;

//! Is the current device iOS 6+?
+ (BOOL)iOS6Plus;

//! Is the current device iOS 7+?
+ (BOOL)iOS7Plus;

//! Does the current device have a camera?
+ (BOOL)hasCamera;

//! Is the current device jailbroken?
+ (BOOL)isJailbroken;

//! Is this an iPad?
+ (BOOL)isPad;

//! Is this a tall screen retina device?
+ (BOOL)isRetina4_5Inch;

@end
