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