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

typedef enum
{
    SKVCDirectionUp = 0,
    SKVCDirectionDown,
    SKVCDirectionLeft,
    SKVCDirectionRight,
    SKVCDirectionIn,
    SKVCDirectionOut
} SKVCDirection;

/**
 * Easily animate adding and removing controllers.
 *
 * @author Jed Laudenslayer
 */
@interface SKAnimatedVC : UIViewController

//! The start point of the SKVCDirectionIn animation.
@property (nonatomic, assign) CGPoint inStartPoint;

//! The start point of the SKVCDirectionOut animation.
@property (nonatomic, assign) CGPoint outEndPoint;

//! Should the controllers be displayed at zero index? Are there other things that need to be above?
@property (nonatomic, assign) BOOL displayAtZeroIndex;

//! Direction added controllers will move.
@property (nonatomic, assign) SKVCDirection addDirection;

//! Direction removed controllers will move.
@property (nonatomic, assign) SKVCDirection removeDirection;

/**
 * Display one of the controllers.
 *
 * @param controller The controller to display
 */
- (void)displayChildViewController:(UIViewController *)controller;

/**
 * Display one of the controllers.
 *
 * @param controller The controller to display
 * @param complete Called when the animation completes.
 */
- (void)displayChildViewController:(UIViewController *)controller withComplete:(void (^)(BOOL finished))complete;

/**
 * remove one of the controllers.
 *
 * @param controller The controller to remove
 */
- (void)popChildViewController:(UIViewController *)controller;

/**
 * Remove one of the controllers.
 *
 * @param controller The controller to remove
 * @param complete Called when the animation completes.
 */
- (void)popChildViewController:(UIViewController *)controller withComplete:(void (^)(BOOL finished))complete;

@end
