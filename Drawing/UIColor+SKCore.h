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
