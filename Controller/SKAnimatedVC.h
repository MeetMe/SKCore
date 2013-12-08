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
