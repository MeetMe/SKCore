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

#import "SKView.h"

#pragma mark -

@implementation SKView

@synthesize drawBlock = drawBlock_;
@synthesize isOverlay = isOverlay_;

#pragma mark - Overridden Class Methods

- (void)updateConstraints
{
    [super updateConstraints];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (self.drawBlock != nil)
    {
        self.drawBlock(rect, self);
    }
}

- (id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    id hitView = [super hitTest:point withEvent:event];

    // Ignore self so only subviews will have interaction enabled.
    if (hitView == self && self.isOverlay)
    {
        return nil;
    }

    return hitView;
}

#pragma mark - Public Class Methods

- (void)setDrawBlock:(SKViewBlock)drawBlock
{
    drawBlock_ = drawBlock;
    self.opaque = drawBlock == nil;
}

@end
