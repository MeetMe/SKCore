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
 * Transformation needed for a specific orientation.
 *
 * @param orientation The orientation to get the transform for.
 * @return The transform
 */
CGAffineTransform SKRotateTransformForOrientation(UIInterfaceOrientation orientation);

/**
 * Convert degrees to radians.
 *
 * @degrees degrees The degrees to convert to radians.
 * @return The radians
 */
CGFloat SKDegreesToRadians(CGFloat degrees);

/**
 * Get the center point for the application.
 *
 * @return The center point of the application.
 */
CGPoint SKAppCenterPoint(void);

/**
 * Get the application frame for a specific orientation.
 *
 * @param orientation The orientation for the frame.
 */
CGRect SKAppFrameForOrientation(UIDeviceOrientation orientation);

/**
 * Category to simplify frame manipulation
 *
 * @author Jed Laudenslayer
 */
@interface UIView (SKFrame)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic, assign) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic, assign) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic, assign) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic, assign) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic, assign) CGFloat width;

/**
 * Set the width of the view while maintaining aspect ratio.
 */
@property (nonatomic, assign) CGFloat aspectWidth;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic, assign) CGFloat height;

/**
 * Set the height of the view while maintaining aspect ratio.
 */
@property (nonatomic, assign) CGFloat aspectHeight;

/**
 * Shortcut for bounds.size.width
 *
 * Sets bounds.size.width = width
 */
@property (nonatomic, assign) CGFloat boundsWidth;

/**
 * Shortcut for bounds.size.height
 *
 * Sets bounds.size.height = height
 */
@property (nonatomic, assign) CGFloat boundsHeight;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic, assign) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic, assign) CGSize size;

/**
 * Scale a CGSize to fill another size
 *
 * @param size The size to scale and return.
 * @param size The size to fit within.
 * @return The scaled Size.
 */
+ (CGSize)scaleSize:(CGSize)scaleSize toFillSize:(CGSize)size;

/**
 * Scale a CGSize to fit within a specific width.
 *
 * @param size The size to scale and return.
 * @param width The width to fit within.
 * @return The scaled Size.
 */
+ (CGSize)scaleSize:(CGSize)size toFitWidth:(float)width;

@end
