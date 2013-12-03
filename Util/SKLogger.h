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

#if ADHOC || DEBUG || TARGET_IPHONE_SIMULATOR
#define SKLOG(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define SKLOG
#endif

/**
 * Logging class used to display log messages in the app.
 *
 * @author Jed Laudenslayer
 */
@interface SKLogger : NSObject

//! Singleton access to the logger.
+ (SKLogger *)sharedInstance;

/**
 * Get all logs as a string to output.
 *
 * @param The array of logs to convert.

 * @return All logs in one string.
 */
+ (NSString *)outputStringForLogs:(NSArray *)logs;

/**
 * Get a human readable string for the log level.
 *
 * @param level The level to get a string for.
 * @return the human readable string.
 */
+ (NSString *)displayStringForLevel:(int)level;

/**
 * Get the UIColor for a specific level.
 *
 * @param level The level to get a color for.
 * @return the UIColor.
 */
+ (UIColor *)colorForLevel:(int)level;

/**
 * Get the logs with the default level.
 *
 * Default level is ASL_LEVEL_WARNING
 */
- (NSArray *)logs;

/**
 * Get the logs with a specific level.
 * Will grab all logs with a level <= the level passed in.
 *
 * ASL_LEVEL_EMERG
 * ASL_LEVEL_ALERT
 * ASL_LEVEL_CRIT
 * ASL_LEVEL_ERR
 * ASL_LEVEL_WARNING
 * ASL_LEVEL_NOTICE
 * ASL_LEVEL_INFO
 * ASL_LEVEL_DEBUG
 *
 * @param level the level of the logs to get.
 */
- (NSArray *)logsWithLevel:(int)level;

@end
