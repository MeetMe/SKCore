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

#import "UIDevice+SKCore.h"

/**
 * Category for generating attributed strings from HTML.
 *
 * @author Joe Szymanski
 */
@interface NSAttributedString (SKHTML)

/**
 * Convenience method to generate an attributed string with an HTML string.
 * NOTE: This will only work on iOS7+
 *
 * @param HTML The HTML string to use to generate the new attributed string.
 * @return An autoreleased instance of the attributed string
 */
+ (instancetype)attributedStringWithHTMLString:(NSString *)HTML;

@end
