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
 * Category for general NSString methods.
 *
 * @author Jed Laudenslayer
 */
@interface NSString (SKCore)

//! Check there is white space and new lines.
@property (nonatomic, assign, readonly) BOOL onlyWhitespaceOrNewlines;

//! Check if a string is valid.
@property (nonatomic, assign, readonly) BOOL isValid;

//! Check if there is any text in the string.
@property (nonatomic, assign, readonly) BOOL anyText;

/**
 * Check if a string contains a substring.
 *
 * @param string The string to search for.
 * @return Returns true id the string was found.
 */
- (BOOL)containsSubString:(NSString *)string;

@end
