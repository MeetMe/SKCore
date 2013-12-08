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

#import "SKShapeTypes.h"

/**
 * Category used to simplify drawing of simple shapes.
 *
 * With this category you can draw shapes based on a path or circles and rectangles
 * based on a CGRect.
 *
 * @author Jed laudenslayer
 */
@interface UIView (SKDrawing)

#pragma mark - Image Capture

/**
 * Get the view as an image.
 *
 * This method will return a UIImage of the contents of a UIView.
 *
 * @param isOpaque Should the image be opaque?
 * @return A UIImage of the current view.
 */
- (UIImage *)asImageOpaque:(BOOL)isOpaque;

/**
 * Get the view as an image.
 *
 * This method will return a UIImage of the contents of a UIView.
 *
 * @return A UIImage of the current view.
 */
- (UIImage *)asImage;

#pragma mark - Generic Shape Methods

/**
 * Draw a shape with options.
 * This method will allow you to draw a complicated shape with a specific fill color, border color and border size.
 * The CGPathRef for the shape must be created in advance and passed to this method.
 *
 * @param path The CGPathRef to fill/stroke.
 * @param fillColor The UIColor to fill the shape with.
 * @param borderColor The UIColor to stroke the shape with.
 * @param borderSize The size of the stroke on the shape.
 */
+ (void)drawShape:(CGPathRef)path fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor andBorderSize:(CGFloat)borderSize;

#pragma mark - Circle Drawing Methods

/**
 * Draw a filled oval within the specified CGRect.
 *
 * @param rect The CGRect that will contain the oval.
 * @param fillColor The UIColor that will fill the oval.
 */
+ (void)drawOvalInRect:(CGRect)rect andFillColor:(UIColor *)fillColor;

/**
 * Draw a stroked oval within the specified CGRect.
 *
 * @param rect The CGRect that will contain the oval.
 * @param borderColor The UIColor that will stroke the oval.
 * @param borderSize The thickness of the stroke around the oval.
 */
+ (void)drawOvalInRect:(CGRect)rect borderColor:(UIColor *)borderColor andBorderSize:(CGFloat)borderSize;

/**
 * Draw a stroked/filled oval within the specified CGRect.
 *
 * @param rect The CGRect that will contain the oval.
 * @param fillColor The UIColor that will fill the oval.
 * @param borderColor The UIColor that will stroke the oval.
 * @param borderSize The thickness of the stroke around the oval.
 */
+ (void)drawOvalInRect:(CGRect)rect withFillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor andBorderSize:(CGFloat)borderSize;

#pragma mark - Triangle Drawing Methods

/**
 * Draw a filled triangle.
 *
 * @param triangle Triangle object to define the position and shape of the triangle.
 * @param fillColor The UIColor that will fill the triangle.
 */
+ (void)drawTriangle:(Triangle)triangle andFillColor:(UIColor *)fillColor;

/**
 * Draw a stroked triangle.
 *
 * @param triangle  Triangle object to define the position and shape of the triangle.
 * @param borderColor The UIColor to stroke with.
 * @param borders The TriBorders object to indicate the border sizes for the triangle.
 */
+ (void)drawTriangle:(Triangle)triangle borderColor:(UIColor *)borderColor andBorders:(TriBorders)borders;

/**
 * Draw a stroked/filled triangle.
 *
 * @param triangle  Triangle object to define the position and shape of the triangle.
 * @param fillColor The UIColor to fill with.
 * @param borderColor The UIColor to stroke with.
 * @param borders The TriBorders object to indicate the border sizes for the triangle.
 */
+ (void)drawTriangle:(Triangle)triangle withFillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor andBorders:(TriBorders)borders;

#pragma mark - Rectangle Drawing Methods

/**
 * Draw a filled rectangle.
 *
 * @param rect The CGRect to draw.
 * @param fillColor The UIColor to fill with.
 */
+ (void)drawRect:(CGRect)rect withFillColor:(UIColor *)fillColor;

/**
 * Draw a stroked rectangle.
 *
 * @param rect The CGRect to draw.
 * @param borderColor The UIColor to stroke the rect with.
 * @param borders The RectBorders object to indicate the border sizes for the rect.
 */
+ (void)drawRect:(CGRect)rect withBorderColor:(UIColor *)borderColor andBorders:(RectBorders)borders;

/**
 * Draw a filled/stroked rectangle.
 *
 * @param rect The CGRect to draw.
 * @param fillColor The UIColor to fill with.
 * @param borderColor The UIColor to stroke the rect with.
 * @param borders The RectBorders object to indicate the border sizes for the rect.
 */
+ (void)drawRect:(CGRect)rect withFillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor andBorders:(RectBorders)borders;

#pragma mark - Rounded Rectangle Drawing Methods

/**
 * Draw a filled rounded rectangle rounding all corners.
 *
 * @param rect The CGRect to draw.
 * @param radius The radius to use for all corners.
 * @param fillColor The UIColor to fill with.
 */
+ (void)drawRoundedRect:(CGRect)rect withRadius:(float)radius andFillColor:(UIColor *)fillColor;

/**
 * Draw a filled rounded rectangle rounding only specific corners.
 *
 * @param rect The CGRect to draw.
 * @param radius The radius to use for all corners.
 * @param fillColor The UIColor to fill with.
 * @param corners The corners to round.
 */
+ (void)drawRoundedRect:(CGRect)rect withRadius:(float)radius fillColor:(UIColor *)fillColor andCorners:(UIRectCorner)corners;

/**
 * Draw a stroked rounded rectangle rounding all corners.
 *
 * @param rect The CGRect to draw.
 * @param radius The radius to use for all corners.
 * @param borderColor The UIColor to use for the borders.
 * @param borderSize The size to use for the stroke of this rounded rect.
 */
+ (void)drawRoundedRect:(CGRect)rect withRadius:(float)radius borderColor:(UIColor *)borderColor andBorderSize:(CGFloat)borderSize;

/**
 * Draw a filled/stroked rounded rectangle rounding all corners.
 *
 * @param rect The CGRect to draw.
 * @param radius The radius to use for all corners.
 * @param fillColor The UIColor to fill with.
 * @param borderColor The UIColor to use for the borders.
 * @param borderSize The size to use for the stroke of this rounded rect.
 */
+ (void)drawRoundedRect:(CGRect)rect withRadius:(float)radius fillColor:(UIColor *)fillColor
            borderColor:(UIColor *)borderColor andBorderSize:(CGFloat)borderSize;

/**
 * Draw a filled/stroked rounded rectangle rounding only specific corners.
 *
 * @param rect The CGRect to draw.
 * @param radius The radius to use for all corners.
 * @param fillColor The color to fill with.
 * @param borderColor The color to use for the borders.
 * @param borderSize The size to use for the stroke of this rounded rect.
 * @param corners The corners to round.
 */
+ (void)drawRoundedRect:(CGRect)rect withRadius:(float)radius fillColor:(UIColor *)fillColor
            borderColor:(UIColor *)borderColor borderSize:(CGFloat)borderSize andCorners:(UIRectCorner)corners;

#pragma mark - Cliping Methods

/**
 * Call this to start clipping your drawing the the CGPathRef passed in.
 *
 * This method is used to start a clip. After this method is called all future
 * drawing will be clipped by this path until endClip is called.
 *
 * @param path The path to clip the drawing to.
 */
+ (void)startClipToPath:(CGPathRef)path;

/**
 * Call this to start clipping your drawing the the CGRect passed in.
 *
 * This method is used to start a clip. After this method is called all future
 * drawing will be clipped by this path until endClip is called.
 *
 * @param rect The CGRect to clip the drawing to.
 */
+ (void)startClipToRect:(CGRect)rect;

/**
 * Call this to start clipping your drawing with a rounded rect, rounding all corners.
 *
 * This method is used to start a clip. After this method is called all future
 * drawing will be clipped by this path until endClip is called.
 *
 * @param rect The rect to clip to.
 * @param cornerRadius The corner radius to clip to.
 */
+ (void)startClipToRoundedRect:(CGRect)rect withCornerRadius:(float)cornerRadius;

/**
 * Call this to start clipping your drawing with a rounded rect, rounding only specific corners.
 *
 * This method is used to start a clip. After this method is called all future
 * drawing will be clipped by this path until endClip is called.
 *
 * @param rect The rect to clip to.
 * @param cornerRadius The corner radius to clip to.
 */
+ (void)startClipToRoundedRect:(CGRect)rect withCornerRadius:(float)cornerRadius andCorners:(UIRectCorner)corners;

/**
 * Call this to start clipping your drawing with a Triangle.
 *
 * This method is used to start a clip. After this method is called all future
 * drawing will be clipped by this path until endClip is called.
 *
 * @param triangle The triangle to clip the drawing to.
 */
+ (void)startClipToTriangle:(Triangle)triangle;

/**
 * Call this to start clipping your drawing with a Oval.
 *
 * This method is used to start a clip. After this method is called all future
 * drawing will be clipped by this path until endClip is called.
 *
 * @param rect The rect the circle should fill.
 */
+ (void)startClipToCircleInRect:(CGRect)rect;

/**
 * <b>EO</b> Call this to start clipping your drawing the the CGPathRef passed in.
 *
 * This method is used to start a clip with the EO rule. After this method is called all future
 * drawing will be clipped by this path until endClip is called.
 *
 * @param path The path to clip the drawing to.
 */
+ (void)startEOClipToPath:(CGPathRef)path;

/**
 * <b>EO</b> Call this to start clipping your drawing the the CGRect passed in.
 *
 * This method is used to start a clip with the EO rule. After this method is called all future
 * drawing will be clipped by this path until endClip is called.
 *
 * @param rect The CGRect to clip the drawing to.
 */
+ (void)startEOClipToRect:(CGRect)rect;

/**
 * <b>EO</b> Call this to start clipping your drawing with a rounded rect, rounding all corners.
 *
 * This method is used to start a clip with the EO rule. After this method is called all future
 * drawing will be clipped by this path until endClip is called.
 *
 * @param rect The rect to clip to.
 * @param cornerRadius The corner radius to clip to.
 */
+ (void)startEOClipToRoundedRect:(CGRect)rect withCornerRadius:(float)cornerRadius;

/**
 * <b>EO</b> Call this to start clipping your drawing with a rounded rect, rounding only specific corners.
 *
 * This method is used to start a clip with the EO rule. After this method is called all future
 * drawing will be clipped by this path until endClip is called.
 *
 * @param rect The rect to clip to.
 * @param cornerRadius The corner radius to clip to.
 */
+ (void)startEOClipToRoundedRect:(CGRect)rect withCornerRadius:(float)cornerRadius andCorners:(UIRectCorner)corners;

/**
 * <b>EO</b> Call this to start clipping your drawing with a Triangle.
 *
 * This method is used to start a clip with the EO rule. After this method is called all future
 * drawing will be clipped by this path until endClip is called.
 *
 * @param triangle The triangle to clip the drawing to.
 */
+ (void)startEOClipToTriangle:(Triangle)triangle;

/**
 * <b>EO</b> Call this to start clipping your drawing with a Oval.
 *
 * This method is used to start a clip with the EO rule. After this method is called all future
 * drawing will be clipped by this path until endClip is called.
 *
 * @param rect The rect the circle should fill.
 */
+ (void)startEOClipToCircleInRect:(CGRect)rect;

/**
 * This method is called when you want to stop clipping the drawing.
 *
 * Call this in conjunction with any startClip or startEOClip Method.
 * Anything beween a start and end clip will be clipped by the path used at the start.
 */
+ (void)endClip;

/**
 * Method used to simplify ending and releasing a path from +startClipToPath: and +startEOClipToPath:
 *
 * @param path The path used to start the clip. Will call CGPathRelease to free the path created for the start clip.
 */
+ (void)endClipToPath:(CGPathRef)CF_RELEASES_ARGUMENT path;

#pragma mark - Drop Shadow Methods

/**
 * Create a drop shadow under all drawing to follow this command.
 *
 * Used this method in conjunction with endShadow. All drawing done between these two commands
 * will have a drop shadow placed underneath.
 *
 * @param offset The offset location of the drop shadow.
 * @param blur The amount to blur the drop shadow.
 */
+ (void)startDropShadow:(CGSize)offset andBlur:(float)blur;

/**
 * Create a drop shadow of a specific UIColor under all drawing to follow this command.
 *
 * Used this method in conjunction with endShadow. All drawing done between these two commands
 * will have a drop shadow placed underneath.
 *
 * @param offset The offset location of the drop shadow.
 * @param blur The amount to blur the drop shadow.
 * @param color The color of the drop shadow.
 */
+ (void)startDropShadow:(CGSize)offset andBlur:(float)blur andColor:(UIColor *)color;

/**
 * This method is called when you want to stop drawing the shapes that will have a drop shadow.
 *
 * Call this in conjunction with any startDropShadow Method.
 * Anything beween a start and end drop shadow will have a drop shadow applied.
 */
+ (void)endShadow;

#pragma mark - Path Methods

/**
 * Create a CGPathRef with a CGRect.
 *
 * @return The CGPathRef created.
 */
+ (CGPathRef)newPathWithRect:(CGRect)rect;

/**
 * Create a CGPathRef with a Triangle.
 *
 * @param triangle Triangle object to hold the points of the triangle.
 * @return The CGPathRef created.
 */
+ (CGPathRef)newPathWithTriangle:(Triangle)triangle;

/**
 * Create an oval CGPathRef within a CGRect.
 *
 * @return The CGPathRef created.
 */
+ (CGPathRef)newPathForCircle:(CGRect)rect;

/**
 * Create a CGPathRef for a rounded rectangle.
 *
 * @param rect The CGRect to define the bounds of the rectangle.
 * @param radius The corner radius for the rectangle.
 * @return The CGPathRef created.
 */
+ (CGPathRef)newRoundedCornerPathWithRect:(CGRect)rect andRadius:(float)radius;

/**
 * Create a CGPathRef for a rounded rectangle.
 *
 * @param rect The CGRect to define the bounds of the rectangle.
 * @param radius The corner radius for the rectangle.
 * @param corners The corner radius for the corners of the rect.
 * @return The CGPathRef created.
 */
+ (CGPathRef)newRoundedCornerPathWithRect:(CGRect)rect radius:(float)radius andCorners:(UIRectCorner)corners;

#pragma mark - Gradient Methods

/**
 * Create a gradient.
 *
 * @param startColor The start color for the gradient.
 * @param endColor The end at the bottom of the gradient.
 * @return CGGradientRef
 */
+ (CGGradientRef)newGradientWithStart:(UIColor *)startColor andEnd:(UIColor *)endColor;

/**
 * Draw a vertical gradient.
 *
 * @param startColor The color for the top of the gradient.
 * @param endColor The color for the bottom of the gradient.
 * @param rect The rect to draw the gradient into.
 */
+ (void)drawVerticalGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor inRect:(CGRect)rect;

/**
 * Draw a horizontal gradient.
 *
 * @param startColor The color for the left of the gradient.
 * @param endColor The color for the right of the gradient.
 * @param rect The rect to draw the gradient into.
 */
+ (void)drawHorizontalGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor inRect:(CGRect)rect;

/**
 * Draw a gradient with control points.
 *
 * @param startColor The color for the start of the gradient.
 * @param endColor The color for the end of the gradient.
 * @param rect The rect to draw the gradient into.
 * @param startPoint The point the gradient should start at.
 * @param endPoint The point the gradient should stop at.
 */
+ (void)drawGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor inRect:(CGRect)rect fromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint;

@end
