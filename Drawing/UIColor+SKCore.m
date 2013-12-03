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

#import "UIColor+SKCore.h"

@implementation UIColor (SKCore)

+ (UIColor *)colorWithHexdecimalString:(NSString *)hexString
{
    NSScanner *scanner;

    uint hex;

    scanner = [NSScanner scannerWithString:hexString];
    BOOL success = [scanner scanHexInt:&hex];

    if (!success)
    {
        return [UIColor whiteColor];
    }

    return [UIColor colorWithHex:hex];
}

+ (UIColor *)colorWithHex:(uint)hex
{
    int red, green, blue, alpha;

    blue = hex & 0x000000FF;
    green = ((hex & 0x0000FF00) >> 8);
    red = ((hex & 0x00FF0000) >> 16);
    alpha = ((hex & 0xFF000000) >> 24);

    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.f];
}

+ (UIColor *)randomColor
{
    CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (uint)hex
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    CGFloat alpha = components[3];

    uint val = 0;
    val = ((uint)(alpha * 0xFF)) << 24;
    val |= ((uint)(red * 0xFF)) << 16;
    val |= ((uint)(green * 0xFF)) << 8;
    val |= ((uint)(blue * 0xFF));
    return val;
}

@end
