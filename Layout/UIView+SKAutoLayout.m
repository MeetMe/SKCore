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

#import "UIView+SKAutoLayout.h"

@implementation UIView (SKAutoLayout)

- (NSArray *)matchParent
{
    UIView *currentView = self;
    UIView *parentView = self.superview;

    NSDictionary *views = NSDictionaryOfVariableBindings(parentView, currentView);

    NSArray *horizontal = [UIView
                           vflConstraints:@"[currentView(==parentView)]"
                           forViews:views];

    NSArray *vertical = [UIView
                         vflConstraints:@"V:[currentView(==parentView)]"
                         forViews:views];

    NSMutableArray *array = [NSMutableArray array];

    [array addObjectsFromArray:horizontal];
    [array addObjectsFromArray:vertical];

    return [NSArray arrayWithArray:array];
}

- (NSArray *)fillParent
{
    return [self fillParentWithPadding:UIEdgeInsetsZero];
}

- (NSArray *)fillParentWithPadding:(UIEdgeInsets)padding
{
    UIView *currentView = self;

    NSDictionary *views = NSDictionaryOfVariableBindings(currentView);

    NSString *hVFL = [NSString stringWithFormat:@"H:|-%f-[currentView]-%f-|", padding.left, padding.right];
    NSString *vVFL = [NSString stringWithFormat:@"V:|-%f-[currentView]-%f-|", padding.top, padding.bottom];

    NSArray *horizontal = [UIView vflConstraints:hVFL forViews:views];
    NSArray *vertical = [UIView vflConstraints:vVFL forViews:views];

    NSMutableArray *array = [NSMutableArray array];

    [array addObjectsFromArray:horizontal];
    [array addObjectsFromArray:vertical];

    return [NSArray arrayWithArray:array];
}

- (NSArray *)centerInParent
{
    NSLayoutConstraint *vertical = [self alignToParent:NSLayoutAttributeCenterY];
    NSLayoutConstraint *horizontal = [self alignToParent:NSLayoutAttributeCenterX];

    NSMutableArray *array = [NSMutableArray array];
    [array addObject:vertical];
    [array addObject:horizontal];

    return [NSArray arrayWithArray:array];
}

- (NSLayoutConstraint *)alignConstraint:(NSLayoutAttribute)attribute toItem:(id)view withAttribute:(NSLayoutAttribute)alignAttribute constant:(CGFloat)c
{
    return [NSLayoutConstraint constraintWithItem:self
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:view
                                        attribute:alignAttribute
                                       multiplier:1.0
                                         constant:c];
}

- (NSLayoutConstraint *)alignConstraint:(NSLayoutAttribute)attribute toItem:(id)view withAttribute:(NSLayoutAttribute)alignAttribute
{
    return [self alignConstraint:attribute toItem:view withAttribute:alignAttribute constant:0.0];
}

- (NSLayoutConstraint *)alignToParent:(NSLayoutAttribute)align
{
    return [self alignConstraint:align toParent:align];
}

- (NSLayoutConstraint *)alignConstraint:(NSLayoutAttribute)attribute toParent:(NSLayoutAttribute)parentAlign
{
    return [NSLayoutConstraint constraintWithItem:self
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:self.superview
                                        attribute:parentAlign
                                       multiplier:1.0
                                         constant:0.0];
}

- (NSLayoutConstraint *)setAttribute:(NSLayoutAttribute)attribute equalTo:(CGFloat)value
{
    return [NSLayoutConstraint constraintWithItem:self
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                        attribute:attribute
                                       multiplier:1.0
                                         constant:value];
}

#pragma mark - Class Selector

+ (NSArray *)vflConstraints:(NSString *)vfl forViews:(NSDictionary *)views
{
    return [NSLayoutConstraint constraintsWithVisualFormat:vfl options:0 metrics:nil views:views];
}

+ (NSArray *)vflConstraints:(NSString *)vfl withMetrics:(NSDictionary *)metrics forViews:(NSDictionary *)views
{
    return [NSLayoutConstraint constraintsWithVisualFormat:vfl options:0 metrics:metrics views:views];
}

@end
