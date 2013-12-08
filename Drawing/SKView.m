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
