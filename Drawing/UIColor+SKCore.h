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

/**
 * Category on UIColor for creating colors.
 *
 * This category add simplified ways of working with UIColor.
 * Including random colors and hex colors.
 *
 * @author Jed Laudenslayer
 */
@interface UIColor (SKCore)

/**
 * Create a UIColor object from a hex value.
 *
 * Common opacity values
 *
 * 75% = BF
 * 60% = 99
 * 50% = 7F
 * 40% = 66
 * 25% = 40
 *
 * @param hex The hexdecimal value for the color including alpha.
 * @return Returns the UIColor object created.
 */
+ (UIColor *)colorWithHex:(uint)hex;

/**
 * Create a UIColor object from a hex string value.
 *
 * @param hexString The hexdecimal value for the color including alpha.
 * @return Returns the UIColor object created.
 */
+ (UIColor *)colorWithHexdecimalString:(NSString *)hexString;

/**
 * Create a random UIColor Object.
 *
 * @return Returns the UIColor object created.
 */
+ (UIColor *)randomColor;

//! Get the hex value of this color as a uint with the form AARRGGBB
- (uint)hex;

@end
