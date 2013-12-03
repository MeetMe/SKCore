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
