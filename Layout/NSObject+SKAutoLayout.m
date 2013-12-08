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
