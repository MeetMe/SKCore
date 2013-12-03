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

#import "SKAnimatedVC.h"

static const CGFloat kAnimationDuration = 0.5;

@implementation SKAnimatedVC
{
    void (^displayCompleteBlock_)(BOOL finished);
    void (^hideCompleteBlock_)(BOOL finished);
}

@synthesize removeDirection = removeDirection_;
@synthesize addDirection = addDirection_;
@synthesize displayAtZeroIndex = displayAtZeroIndex_;
@synthesize inStartPoint = inStartPoint_;
@synthesize outEndPoint = outEndPoint_;

- (instancetype)init
{
    self = [super init];

    if (self != nil)
    {
        removeDirection_ = SKVCDirectionDown;
        addDirection_ = SKVCDirectionUp;
    }

    return self;
}

- (void)dealloc
{
    displayCompleteBlock_ = nil;
    hideCompleteBlock_ = nil;
}

#pragma mark - Public Methods

- (void)displayChildViewController:(UIViewController *)controller
{
    if (controller.parentViewController == self) return;
    controller.view.translatesAutoresizingMaskIntoConstraints = NO;

    [self addChildVC:controller bottom:self.displayAtZeroIndex];

    [controller.view beginConstraints];
    [controller.view addLayoutConstraints:[controller.view matchParent]];
    [controller.view addLayoutConstraint:[controller.view alignToParent:NSLayoutAttributeLeft]];
    [controller.view addLayoutConstraint:[controller.view alignToParent:NSLayoutAttributeTop]];

    [self.view addConstraints:[controller.view endConstraintsAndClear:NO]];

    // -- Apply the changes now
    [self.view layoutSubviews];
}

- (void)displayChildViewController:(UIViewController *)controller withComplete:(void (^)(BOOL finished))complete
{
    if (controller.parentViewController == self) return;
    controller.view.translatesAutoresizingMaskIntoConstraints = NO;

    displayCompleteBlock_ = complete;

    [self addChildVC:controller bottom:self.displayAtZeroIndex];

    [controller.view beginConstraints];
    [controller.view addLayoutConstraints:[self constraintsForController:controller add:YES start:YES]];

    [self.view addConstraints:[controller.view endConstraintsAndClear:NO]];
    [self.view layoutIfNeeded];

    if (self.addDirection != SKVCDirectionIn)
    {
        [self.view removeConstraints:[controller.view endConstraintsAndClear:YES]];

        [controller.view beginConstraints];
        [controller.view addLayoutConstraints:[self constraintsForController:controller add:YES start:NO]];

        [self.view addConstraints:[controller.view endConstraintsAndClear:NO]];

        __block __weak SKAnimatedVC *weakSelf = self;
        [UIView animateWithDuration:kAnimationDuration animations:[^(void) {

            SKAnimatedVC *strongSelf = weakSelf;

            if (strongSelf != nil)
            {
                [strongSelf.view layoutIfNeeded];
            }

        } copy] completion:[^(BOOL finished) {

            SKAnimatedVC *strongSelf = weakSelf;

            if (strongSelf != nil)
            {
                if (strongSelf->displayCompleteBlock_ != nil)
                {
                    strongSelf->displayCompleteBlock_(YES);
                    strongSelf->displayCompleteBlock_ = nil;
                }
            }

        } copy]];
    }
    else
    {
        [self scaleIn:controller];
    }
}

- (void)popChildViewController:(UIViewController *)controller
{
    if (controller.view.superview != self.view) return;

    NSArray *existingConstraints = [controller.view endConstraintsAndClear:NO];

    if (existingConstraints != nil)
    {
        [self.view removeConstraints:[controller.view endConstraintsAndClear:YES]];
        [self.view layoutIfNeeded];
    }

    [self removeChildVC:controller];
}

- (void)popChildViewController:(UIViewController *)controller withComplete:(void (^)(BOOL finished))complete
{
    if (controller.view.superview != self.view) return;

    hideCompleteBlock_ = complete;

    NSArray *existingConstraints = [controller.view endConstraintsAndClear:NO];
    if (existingConstraints != nil)
    {
        [self.view removeConstraints:[controller.view endConstraintsAndClear:YES]];
    }

    [controller.view beginConstraints];
    [controller.view addLayoutConstraints:[self constraintsForController:controller add:NO start:YES]];

    [self.view addConstraints:[controller.view endConstraintsAndClear:NO]];

    if (self.removeDirection != SKVCDirectionOut)
    {
        __block __weak SKAnimatedVC *weakSelf = self;

        [UIView animateWithDuration:kAnimationDuration animations:[^(void) {

            SKAnimatedVC *strongSelf = weakSelf;

            if (strongSelf != nil)
            {
                [strongSelf.view layoutIfNeeded];
            }

        } copy] completion:[^(BOOL finished) {

            SKAnimatedVC *strongSelf = weakSelf;

            if (strongSelf != nil)
            {
                [self popChildViewController:controller];

                if (strongSelf->hideCompleteBlock_ != nil)
                {
                    strongSelf->hideCompleteBlock_(YES);
                    strongSelf->hideCompleteBlock_ = nil;
                }
            }

        } copy]];
    }
    else
    {
        [self.view layoutIfNeeded];
        [self scaleOut:controller];
    }
}

- (void)scaleIn:(UIViewController *)controller
{
    controller.view.center = self.inStartPoint;

    // SHOW
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.delegate = self;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.0],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:1.0], nil];

    bounceAnimation.duration = kAnimationDuration;
    bounceAnimation.removedOnCompletion = YES;
    [bounceAnimation setValue:@"open" forKey:@"name"];

    [controller.view.layer addAnimation:bounceAnimation forKey:@"open"];

    __block __weak SKAnimatedVC *weakSelf = self;
    [UIView
     animateWithDuration:kAnimationDuration
     animations:^(void) {

         SKAnimatedVC *strongSelf = weakSelf;
         if (strongSelf != nil)
         {
             controller.view.center = strongSelf.view.center;
             controller.view.alpha = 1.0;
         }
     }];
}

- (void)scaleOut:(UIViewController *)controller
{
    controller.view.center = self.view.center;

    // HIDE
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.delegate = self;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:1.0],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.0], nil];

    bounceAnimation.duration = kAnimationDuration;
    bounceAnimation.removedOnCompletion = YES;
    [bounceAnimation setValue:@"close" forKey:@"name"];

    [controller.view.layer addAnimation:bounceAnimation forKey:@"close"];

    __block __weak SKAnimatedVC *weakSelf = self;
    [UIView
     animateWithDuration:kAnimationDuration
     animations:^(void) {

         SKAnimatedVC *strongSelf = weakSelf;
         if (strongSelf != nil)
         {
             controller.view.alpha = 0.0;
             controller.view.center = strongSelf.outEndPoint;
         }

     } completion:^(BOOL done) {

         SKAnimatedVC *strongSelf = weakSelf;
         if (strongSelf != nil)
         {
             [strongSelf popChildViewController:controller];
         }

     }];
}

#pragma mark - Private Methods

- (NSArray *)constraintsForController:(UIViewController *)controller add:(BOOL)add start:(BOOL)start
{
    NSMutableArray *layoutConstraints = [NSMutableArray arrayWithArray:[controller.view matchParent]];

    SKVCDirection direction = add ? self.addDirection : self.removeDirection;

    switch (direction)
    {
        case SKVCDirectionUp:
        {
            [layoutConstraints addObject:[controller.view alignConstraint:NSLayoutAttributeLeft toParent:NSLayoutAttributeLeft]];

            NSLayoutAttribute attribute = start ? NSLayoutAttributeBottom : NSLayoutAttributeTop;

            if (add)
            {
                attribute = start ? NSLayoutAttributeTop : NSLayoutAttributeBottom;
            }

            [layoutConstraints
             addObject:[controller.view
                        alignConstraint:attribute
                        toParent:add ? NSLayoutAttributeBottom : NSLayoutAttributeTop]];
            break;
        }

        case SKVCDirectionDown:
        {
            [layoutConstraints addObject:[controller.view alignConstraint:NSLayoutAttributeLeft toParent:NSLayoutAttributeLeft]];

            NSLayoutAttribute attribute = start ? NSLayoutAttributeTop : NSLayoutAttributeBottom;

            if (add)
            {
                attribute = start ? NSLayoutAttributeBottom : NSLayoutAttributeTop;
            }

            [layoutConstraints
             addObject:[controller.view
                        alignConstraint:attribute
                        toParent:add ? NSLayoutAttributeTop : NSLayoutAttributeBottom]];
            break;
        }

        case SKVCDirectionLeft:
        {
            [layoutConstraints addObject:[controller.view alignConstraint:NSLayoutAttributeTop toParent:NSLayoutAttributeTop]];

            NSLayoutAttribute attribute = start ? NSLayoutAttributeRight : NSLayoutAttributeLeft;

            if (add)
            {
                attribute = start ? NSLayoutAttributeLeft : NSLayoutAttributeRight;
            }

            [layoutConstraints
             addObject:[controller.view
                        alignConstraint:attribute
                        toParent:add ? NSLayoutAttributeRight : NSLayoutAttributeLeft]];
            break;
        }

        case SKVCDirectionRight:
        {
            [layoutConstraints addObject:[controller.view alignConstraint:NSLayoutAttributeTop toParent:NSLayoutAttributeTop]];

            NSLayoutAttribute attribute = start ? NSLayoutAttributeLeft : NSLayoutAttributeRight;

            if (add)
            {
                attribute = start ? NSLayoutAttributeRight : NSLayoutAttributeLeft;
            }

            [layoutConstraints
             addObject:[controller.view
                        alignConstraint:attribute
                        toParent:add ? NSLayoutAttributeLeft : NSLayoutAttributeRight]];
            break;
        }

        case SKVCDirectionOut:
        case SKVCDirectionIn:
        {
            [layoutConstraints addObject:[controller.view alignConstraint:NSLayoutAttributeTop toParent:NSLayoutAttributeTop]];

            [layoutConstraints
             addObject:[controller.view
                        alignConstraint:NSLayoutAttributeLeft
                        toParent:NSLayoutAttributeLeft]];
            break;
        }
    }

    return [NSArray arrayWithArray:layoutConstraints];
}

#pragma mark - Animation Delegate

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    if (flag)
    {
        BOOL open = [[animation valueForKey:@"name"] isEqualToString:@"open"];

        if (open && displayCompleteBlock_ != nil)
        {
            displayCompleteBlock_(YES);
            displayCompleteBlock_ = nil;
        }
        else if (!open && hideCompleteBlock_ != nil)
        {
            hideCompleteBlock_(YES);
            hideCompleteBlock_ = nil;
        }
    }
}

@end
