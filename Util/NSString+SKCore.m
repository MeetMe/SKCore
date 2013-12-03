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

#import "NSString+SKCore.h"

@implementation NSString (SKCore)

- (BOOL)containsSubString:(NSString *)string
{
    if (!string.isValid)
    {
        return NO;
    }
    NSRange textRange = [self rangeOfString:string options:NSCaseInsensitiveSearch];
    return textRange.location != NSNotFound;
}

- (BOOL)anyText
{
    return [self isKindOfClass:[NSString class]] && [self length] > 0;
}

- (BOOL)isValid
{
    return self.anyText && !self.onlyWhitespaceOrNewlines;
}

- (BOOL)onlyWhitespaceOrNewlines
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSRange range = [self rangeOfCharacterFromSet:[whitespace invertedSet]];

    return range.location == NSNotFound;
}

@end
