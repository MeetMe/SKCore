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

#import "SKLogger.h"
#import "asl.h"

@implementation SKLogger

static SKLogger *volatile sharedInstance = nil;

+ (SKLogger *)sharedInstance
{
    static dispatch_once_t sharedInstanceToken;
    dispatch_once(&sharedInstanceToken, ^{
        sharedInstance = [[SKLogger alloc] init];
    });
    return sharedInstance;
}

+ (NSString *)outputStringForLogs:(NSArray *)logs
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];

    NSMutableString *output = [[NSMutableString alloc] init];
    for (NSDictionary *log in logs)
    {
        NSDate *time = [NSDate dateWithTimeIntervalSince1970:[[log objectForKey:@"Time"] intValue]];
        [output appendFormat:@"%@ %@\n",
         [formatter stringFromDate:time],
         [log objectForKey:@"Message"]];
    }

    return output;
}

+ (NSString *)displayStringForLevel:(int)level
{
    switch (level)
    {
        case ASL_LEVEL_EMERG:
            return @"Emergency";
            break;

        case ASL_LEVEL_ALERT:
            return @"Alert";
            break;

        case ASL_LEVEL_CRIT:
            return @"Critical";
            break;

        case ASL_LEVEL_ERR:
            return @"Error";
            break;

        case ASL_LEVEL_WARNING:
            return @"Warning";
            break;

        case ASL_LEVEL_NOTICE:
            return @"Notice";
            break;

        case ASL_LEVEL_INFO:
            return @"Info";
            break;

        case ASL_LEVEL_DEBUG:
            return @"Debug";
            break;

        default:
            return @"";
            break;
    }

    return @"";
}

+ (UIColor *)colorForLevel:(int)level
{
    switch (level)
    {
        case ASL_LEVEL_EMERG:
            return [UIColor redColor];
            break;

        case ASL_LEVEL_ALERT:
            return [UIColor redColor];
            break;

        case ASL_LEVEL_CRIT:
            return [UIColor redColor];
            break;

        case ASL_LEVEL_ERR:
            return [UIColor redColor];
            break;

        case ASL_LEVEL_WARNING:
            return [UIColor yellowColor];
            break;

        case ASL_LEVEL_NOTICE:
            return [UIColor yellowColor];
            break;

        case ASL_LEVEL_INFO:
            return [UIColor greenColor];
            break;

        case ASL_LEVEL_DEBUG:
            return [UIColor greenColor];
            break;

        default:
            return [UIColor greenColor];
            break;
    }

    return [UIColor greenColor];
}

#pragma mark - Public Methods

- (NSArray *)logs
{
    return [self logsWithLevel:ASL_LEVEL_WARNING];
}

- (NSArray *)logsWithLevel:(int)level
{
    aslmsg q, m;
    int i;
    const char *key, *val;

    q = asl_new(ASL_TYPE_QUERY);

    NSString *appName = [[NSProcessInfo processInfo] processName];
    NSString *pid = [NSString stringWithFormat:@"%d", [[NSProcessInfo processInfo] processIdentifier]];
    NSString *levelStr = [NSString stringWithFormat:@"%d", level];

    asl_set_query(q, ASL_KEY_SENDER, [appName UTF8String], ASL_QUERY_OP_EQUAL);
    asl_set_query(q, ASL_KEY_PID, [pid UTF8String], ASL_QUERY_OP_EQUAL);
    asl_set_query(q, ASL_KEY_LEVEL, [levelStr UTF8String], ASL_QUERY_OP_GREATER_EQUAL);

    NSMutableArray *logs = [NSMutableArray array];

    aslresponse r = asl_search(NULL, q);
    while (NULL != (m = aslresponse_next(r)))
    {
        NSMutableDictionary *log = [NSMutableDictionary dictionary];

        for (i = 0; (NULL != (key = asl_key(m, i))); i++)
        {
            NSString *keyString = [NSString stringWithUTF8String:(char *)key];

            val = asl_get(m, key);

            NSString *string = [NSString stringWithUTF8String:val];
            [log setObject:string forKey:keyString];
        }

        [logs addObject:log];
    }

    aslresponse_free(r);

    return [NSArray arrayWithArray:logs];
}

@end
