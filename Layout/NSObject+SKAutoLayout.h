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
 * Category to simplify creating and storing a set of constraints on any object.
 *
 * @author Jed Laudenslayer
 */
@interface NSObject (SKAutoLayout)

#pragma mark - Constraint managment

/**
 * Used to start building a set of constraints that will not utilize VFL.
 *
 * Initialize a state where you can easily manage the creation of an array of constraints.
 */
- (void)beginConstraints;

/**
 * Used to start building a set of constraints that will utilize VFL.
 *
 * Initialize a state where you can easily manage the creation of an array of constraints based on VFL.
 *
 * @param metrics The metrics to be used in all add calls until -endVFL is called.
 * @param views The views to be used in all add calls until -endVFL is called.
 */
- (void)beginConstraintsWithMetrics:(NSDictionary *)metrics forViews:(NSDictionary *)views;

/**
 * Add a VFL string using the metrics and views specified in the -beginVFLWithMetrics:forViews: method.
 *
 * @param VFL The VFL string.
 */
- (void)addVFL:(NSString *)VFL;

/**
 * Used to manually insert normal NSLayoutConstraints along with VFL created constraints.
 *
 * @param constraint The constraint to add.
 */
- (void)addLayoutConstraint:(NSLayoutConstraint *)constraint;

/**
 * Used to manually insert normal NSLayoutConstraints along with VFL created constraints.
 *
 * @param constraint The constraint to add.
 */
- (void)addLayoutConstraints:(NSArray *)constraints;

/**
 * End and cleanup the constraint managment pass back all constraints created.
 *
 * Calls - endConstraintsAndClear:YES
 *
 * @return The array of constraints created since the call to the -beginVFLWithMetrics:forViews: method.
 */
- (NSArray *)endConstraints;

/**
 * End and cleanup the constraint managment pass back all constraints created.
 *
 * @param clear Should the constraints be clear of should the view continue to store them.
 * @return The array of constraints created since the call to the -beginVFLWithMetrics:forViews: method.
 */
- (NSArray *)endConstraintsAndClear:(BOOL)clear;

@end
