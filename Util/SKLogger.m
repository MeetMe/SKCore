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
