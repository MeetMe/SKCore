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
