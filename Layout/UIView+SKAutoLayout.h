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
 * @param c The constant value to add to the alignment.
 * @return The NSLayoutConstraint created.
 */
- (NSLayoutConstraint *)alignToParent:(NSLayoutAttribute)align constant:(CGFloat)c;

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
