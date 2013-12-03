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
 * Category for more easily dealing with child view controllers.
 *
 * @author Jed Laudenslayer
 */
@interface UIViewController (Children)

/**
 * Add a child view controller.
 *
 * Calls -didMoveToParentViewController: on the childVC after
 * adding its view as a child view of the current controller.
 *
 * @param childVC The child view controller to add.
 */
- (void)addChildVC:(UIViewController *)childVC;

/**
 * Add a child view controller.
 *
 * Calls -didMoveToParentViewController: on the childVC after
 * adding its view as a child view of the current controller.
 *
 * @param childVC The child view controller to add.
 * @param bottom Should it be placed on the bottom of the stack?
 */
- (void)addChildVC:(UIViewController *)childVC bottom:(BOOL)bottom;

/**
 * Add a child view controller.
 *
 * Calls -willMoveToParentViewController: on the childVC before
 * removing its view.
 *
 * @param childVC The child view controller to remove.
 */
- (void)removeChildVC:(UIViewController *)childVC;

@end
