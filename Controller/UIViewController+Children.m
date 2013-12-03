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

#import "UIViewController+Children.h"

@implementation UIViewController (Children)

- (void)addChildVC:(UIViewController *)childVC
{
    [self addChildVC:childVC bottom:NO];
}

- (void)addChildVC:(UIViewController *)childVC bottom:(BOOL)bottom
{
    [childVC willMoveToParentViewController:self];
    [self addChildViewController:childVC];

    if (bottom)
    {
        [self.view insertSubview:childVC.view atIndex:0];
    }
    else
    {
        [self.view addSubview:childVC.view];
    }

    [childVC didMoveToParentViewController:self];
}

- (void)removeChildVC:(UIViewController *)childVC
{
    [childVC willMoveToParentViewController:nil];
    [childVC.view removeFromSuperview];
    [childVC removeFromParentViewController];
    [childVC didMoveToParentViewController:nil];
}

@end
