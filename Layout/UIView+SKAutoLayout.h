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
 * Category to simplify common automatic layout conditions.
 *
 * @author Jed Laudenslayer
 */
@interface UIView (SKAutoLayout)

/**
 * This method will make a view the same size as it's parent.
 *
 * Note: Be sure superview is not nil before calling this.
 *
 * @return The array of contraints created.
 */
- (NSArray *)matchParent;

/**
 * This method will make a view fill its parent.
 *
 * Note: Be sure superview is not nil before calling this.
 *
 * @return The array of contraints created.
 */
- (NSArray *)fillParent;

/**
 * This method will make a view fill its parent.
 *
 * Note: Be sure superview is not nil before calling this.
 * @param padding The padding to leave around the view.
 * @return The array of contraints created.
 */
- (NSArray *)fillParentWithPadding:(UIEdgeInsets)padding;

/**
 * Create constraints to center a view in it's parent.
 *
 * @return The array of constraints.
 */
- (NSArray *)centerInParent;

/**
 * Align a view to another view
 *
 * @param attribute The attribute to align
 * @param view The view to align with.
 * @param alignAttribute The attribute to align to.
 * @param c The constant value to add to the alignment.
 * @return The NSLayoutConstraint created.
 */
- (NSLayoutConstraint *)alignConstraint:(NSLayoutAttribute)attribute toItem:(id)view withAttribute:(NSLayoutAttribute)alignAttribute constant:(CGFloat)c;

/**
 * Align a view to another view
 *
 * @param attribute The attribute to align
 * @param view The view to align with.
 * @param alignAttribute The attribute to align to.
 * @return The NSLayoutConstraint created.
 */
- (NSLayoutConstraint *)alignConstraint:(NSLayoutAttribute)attribute toItem:(id)view withAttribute:(NSLayoutAttribute)alignAttribute;

/**
 * Align a view to it's parent.
 *
 * @param align The attribute that should match it's parent
 * @return The NSLayoutConstraint created.
 */
- (NSLayoutConstraint *)alignToParent:(NSLayoutAttribute)align;

/**
 * Align a view to it's parent.
 *
 * @param attribute The side of the view that should align to the parent.
 * @param parentAlign The side of the parent that the view should align to.
 * @return The NSLayoutConstraint created.
 */
- (NSLayoutConstraint *)alignConstraint:(NSLayoutAttribute)attribute toParent:(NSLayoutAttribute)parentAlign;

/**
 * Set an attribute equal to a specific value.
 *
 * @param attribute The attribute that should equal the value
 * @param value The value to set the attribute to.
 * @return The NSLayoutConstraint created.
 */
- (NSLayoutConstraint *)setAttribute:(NSLayoutAttribute)attribute equalTo:(CGFloat)value;

#pragma mark - Class Methods

/**
 * Add constraints using the visual format language.
 *
 * @param vfl The Visual Format Language string.
 * @param views The dictionary of views for the vfl.
 * @return The array of contraints created.
 */
+ (NSArray *)vflConstraints:(NSString *)vfl forViews:(NSDictionary *)views;

/**
 * Add constraints using the visual format language.
 *
 * @param vfl The Visual Format Language string.
 * @param metrics Dictionary of key/value used in the VFL string.
 * @param views The dictionary of views for the vfl.
 * @return The array of contraints created.
 */
+ (NSArray *)vflConstraints:(NSString *)vfl withMetrics:(NSDictionary *)metrics forViews:(NSDictionary *)views;

@end
