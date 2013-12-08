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
