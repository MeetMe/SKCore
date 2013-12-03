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

#import "NSObject+SKAutoLayout.h"
#import <objc/runtime.h>

static char const * const s_VFLViewsTag = "VFLViews";
static char const * const s_VFLMetricsTag = "VFLMetrics";
static char const * const s_layoutConstraintsTag = "layoutConstraints";

@implementation NSObject (SKAutoLayout)

#pragma mark - Constraint managment

- (NSMutableArray *)layoutConstraints
{
    NSMutableArray *array = objc_getAssociatedObject(self, s_layoutConstraintsTag);

    if (array == nil)
    {
        array = [NSMutableArray array];
        objc_setAssociatedObject(self, s_layoutConstraintsTag, [NSMutableArray array], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return array;
}

- (void)beginConstraints
{
    [self beginConstraintsWithMetrics:nil forViews:nil];
}

- (void)beginConstraintsWithMetrics:(NSDictionary *)metrics forViews:(NSDictionary *)views
{
    objc_setAssociatedObject(self, s_layoutConstraintsTag, [NSMutableArray array], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, s_VFLMetricsTag, [metrics copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, s_VFLViewsTag, [views copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addLayoutConstraint:(NSLayoutConstraint *)constraint
{
    [[self layoutConstraints] addObject:constraint];
}

- (void)addLayoutConstraints:(NSArray *)constraints
{
    [[self layoutConstraints] addObjectsFromArray:constraints];
}

- (void)addVFL:(NSString *)VFL
{
    NSDictionary *metrics = objc_getAssociatedObject(self, s_VFLMetricsTag);
    NSDictionary *views = objc_getAssociatedObject(self, s_VFLViewsTag);

    [[self layoutConstraints]
     addObjectsFromArray:[UIView
                          vflConstraints:VFL
                          withMetrics:metrics
                          forViews:views]];
}

- (NSArray *)endConstraints
{
    return [self endConstraintsAndClear:YES];
}

- (NSArray *)endConstraintsAndClear:(BOOL)clear
{
    NSArray *constraints = [[self layoutConstraints] copy];

    if (clear)
    {
        objc_setAssociatedObject(self, s_layoutConstraintsTag, [NSMutableArray array], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, s_VFLMetricsTag, @{}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, s_VFLViewsTag, @{}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return [NSArray arrayWithArray:constraints];
}

@end
