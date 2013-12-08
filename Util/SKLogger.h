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
