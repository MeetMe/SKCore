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

#import "UIView+SKDrawing.h"

@implementation UIView (DrawKit)

#pragma mark - Image Capture

- (UIImage *)asImageOpaque:(BOOL)isOpaque
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, isOpaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return viewImage;
}

- (UIImage *)asImage
{
    return [self asImageOpaque:self.opaque];
}

#pragma mark - Generic Shape Methods

+ (void)drawShape:(CGPathRef)path fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor andBorderSize:(CGFloat)borderSize
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (fillColor != nil)
    {
        CGPathRef fillPath = CGPathCreateCopy(path);

        CGContextAddPath(context, fillPath);
        CGPathRelease(fillPath);

        CGContextSetFillColorWithColor(context, fillColor.CGColor);

        CGContextFillPath(context);
    }

    if (borderColor != nil)
    {
        CGPathRef borderPath = CGPathCreateCopy(path);

        CGContextAddPath(context, borderPath);
        CGPathRelease(borderPath);

        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        CGContextSetLineWidth(context, borderSize > 0 ? borderSize : 1);

        CGContextStrokePath(context);
    }
}

#pragma mark - Circle Drawing Methods

+ (void)drawOvalInRect:(CGRect)rect andFillColor:(UIColor *)fillColor
{
    [self drawOvalInRect:rect withFillColor:fillColor borderColor:nil andBorderSize:0];
}

+ (void)drawOvalInRect:(CGRect)rect borderColor:(UIColor *)borderColor andBorderSize:(CGFloat)borderSize
{
    [self drawOvalInRect:rect withFillColor:nil borderColor:borderColor andBorderSize:borderSize];
}

+ (void)drawOvalInRect:(CGRect)rect withFillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor andBorderSize:(CGFloat)borderSize
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (fillColor != nil)
    {
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextAddEllipseInRect(context, rect);
        CGContextFillPath(context);
    }

    if (borderColor != nil)
    {
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        CGContextSetLineWidth(context, borderSize);
        CGContextAddEllipseInRect(context, rect);
        CGContextStrokePath(context);
    }
}

#pragma mark - Triangle Drawing Methods

+ (void)drawTriangle:(Triangle)triangle andFillColor:(UIColor *)fillColor
{
    [self drawTriangle:triangle withFillColor:fillColor borderColor:nil andBorders:TriBordersZero];
}

+ (void)drawTriangle:(Triangle)triangle borderColor:(UIColor *)borderColor andBorders:(TriBorders)borders
{
    [self drawTriangle:triangle withFillColor:nil borderColor:borderColor andBorders:borders];
}

+ (void)drawTriangle:(Triangle)triangle withFillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor andBorders:(TriBorders)borders
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (fillColor != nil)
    {
        CGContextSetFillColorWithColor(context, fillColor.CGColor);

        CGContextMoveToPoint(context, triangle.a.x, triangle.a.y);
        CGContextAddLineToPoint(context, triangle.b.x, triangle.b.y);
        CGContextAddLineToPoint(context, triangle.c.x, triangle.c.y);
        CGContextAddLineToPoint(context, triangle.a.x, triangle.a.y);

        CGContextFillPath(context);
    }

    if (borderColor != nil)
    {
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);

        CGContextMoveToPoint(context, triangle.a.x, triangle.a.y);
        CGContextSetLineWidth(context, borders.a);
        CGContextAddLineToPoint(context, triangle.b.x, triangle.b.y);
        CGContextStrokePath(context);

        CGContextMoveToPoint(context, triangle.b.x, triangle.b.y);
        CGContextSetLineWidth(context, borders.b);
        CGContextAddLineToPoint(context, triangle.c.x, triangle.c.y);
        CGContextStrokePath(context);

        CGContextMoveToPoint(context, triangle.c.x, triangle.c.y);
        CGContextSetLineWidth(context, borders.c);
        CGContextAddLineToPoint(context, triangle.a.x, triangle.a.y);
        CGContextStrokePath(context);
    }
}

#pragma mark - Rectangle Drawing Methods

+ (void)drawRect:(CGRect)rect withFillColor:(UIColor *)fillColor
{
    [self drawRect:rect withFillColor:fillColor borderColor:nil andBorders:RectBordersZero];
}

+ (void)drawRect:(CGRect)rect withBorderColor:(UIColor *)borderColor andBorders:(RectBorders)borders;
{
    [self drawRect:rect withFillColor:nil borderColor:borderColor andBorders:borders];
}

+ (void)drawRect:(CGRect)rect withFillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor andBorders:(RectBorders)borders;
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (fillColor != nil)
    {
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillRect(context, rect);
    }

    if (borderColor != nil)
    {
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);

        CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
        CGContextSetLineWidth(context, borders.top);
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
        CGContextStrokePath(context);

        CGContextMoveToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
        CGContextSetLineWidth(context, borders.right);
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
        CGContextStrokePath(context);

        CGContextMoveToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
        CGContextSetLineWidth(context, borders.bottom);
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
        CGContextStrokePath(context);

        CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
        CGContextSetLineWidth(context, borders.left);
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
        CGContextStrokePath(context);
    }
}

#pragma mark - Rounded Rectangle Drawing Methods

+ (void)drawRoundedRect:(CGRect)rect withRadius:(float)radius andFillColor:(UIColor *)fillColor
{
    [self drawRoundedRect:rect withRadius:radius fillColor:fillColor borderColor:nil borderSize:0.0 andCorners:UIRectCornerAllCorners];
}

+ (void)drawRoundedRect:(CGRect)rect withRadius:(float)radius fillColor:(UIColor *)fillColor andCorners:(UIRectCorner)corners
{
    [self drawRoundedRect:rect withRadius:radius fillColor:fillColor borderColor:nil borderSize:0.0 andCorners:corners];
}

+ (void)drawRoundedRect:(CGRect)rect withRadius:(float)radius borderColor:(UIColor *)borderColor andBorderSize:(CGFloat)borderSize
{
    [self drawRoundedRect:rect withRadius:radius fillColor:nil borderColor:borderColor borderSize:borderSize andCorners:UIRectCornerAllCorners];
}

+ (void)drawRoundedRect:(CGRect)rect withRadius:(float)radius fillColor:(UIColor *)fillColor
            borderColor:(UIColor *)borderColor andBorderSize:(CGFloat)borderSize
{
    [self drawRoundedRect:rect withRadius:radius fillColor:fillColor borderColor:borderColor borderSize:borderSize andCorners:UIRectCornerAllCorners];
}

+ (void)drawRoundedRect:(CGRect)rect withRadius:(float)radius fillColor:(UIColor *)fillColor
            borderColor:(UIColor *)borderColor borderSize:(CGFloat)borderSize andCorners:(UIRectCorner)corners
{
    if (borderColor != nil)
    {
        rect = CGRectInset(rect, borderSize * 0.5, borderSize * 0.5);
    }

    CGPathRef path = [UIView newRoundedCornerPathWithRect:rect radius:radius andCorners:corners];
    [self drawShape:path fillColor:fillColor borderColor:borderColor andBorderSize:borderSize];
    CGPathRelease(path);
}

#pragma mark - Cliping Methods

+ (void)startClipToPath:(CGPathRef)path
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGContextAddPath(context, path);
    CGContextClip(context);
}

+ (void)startClipToRect:(CGRect)rect
{
    CGPathRef rectPath = [UIView newPathWithRect:rect];
    [self startClipToPath:rectPath];
    CGPathRelease(rectPath);
}

+ (void)startClipToRoundedRect:(CGRect)rect withCornerRadius:(float)cornerRadius
{
    [self startClipToRoundedRect:rect withCornerRadius:cornerRadius andCorners:UIRectCornerAllCorners];
}

+ (void)startClipToRoundedRect:(CGRect)rect withCornerRadius:(float)cornerRadius andCorners:(UIRectCorner)corners
{
    CGPathRef rectPath = [UIView newRoundedCornerPathWithRect:rect radius:cornerRadius andCorners:corners];
    [self startClipToPath:rectPath];
    CGPathRelease(rectPath);
}

+ (void)startClipToTriangle:(Triangle)triangle
{
    CGPathRef trianglePath = [UIView newPathWithTriangle:triangle];
    [self startClipToPath:trianglePath];
    CGPathRelease(trianglePath);
}

+ (void)startClipToCircleInRect:(CGRect)rect
{
    CGPathRef path = [UIView newPathForCircle:rect];
    [self startClipToPath:path];
    CGPathRelease(path);
}

+ (void)startEOClipToPath:(CGPathRef)path
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGContextEOClip(context);
    CGContextAddPath(context, path);
}

+ (void)startEOClipToRect:(CGRect)rect
{
    CGPathRef rectPath = [UIView newPathWithRect:rect];
    [self startEOClipToPath:rectPath];
    CGPathRelease(rectPath);
}

+ (void)startEOClipToRoundedRect:(CGRect)rect withCornerRadius:(float)cornerRadius
{
    [self startEOClipToRoundedRect:rect withCornerRadius:cornerRadius andCorners:UIRectCornerAllCorners];
}

+ (void)startEOClipToRoundedRect:(CGRect)rect withCornerRadius:(float)cornerRadius andCorners:(UIRectCorner)corners
{
    CGPathRef rectPath = [UIView newRoundedCornerPathWithRect:rect radius:cornerRadius andCorners:corners];
    [self startEOClipToPath:rectPath];
    CGPathRelease(rectPath);
}

+ (void)startEOClipToTriangle:(Triangle)triangle
{
    CGPathRef trianglePath = [UIView newPathWithTriangle:triangle];
    [self startEOClipToPath:trianglePath];
    CGPathRelease(trianglePath);
}

+ (void)startEOClipToCircleInRect:(CGRect)rect
{
    CGPathRef path = [UIView newPathForCircle:rect];
    [self startEOClipToPath:path];
    CGPathRelease(path);
}

+ (void)endClip
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextRestoreGState(context);
}

+ (void)endClipToPath:(CGPathRef)path
{
    [self endClip];
    CGPathRelease(path);
}

#pragma mark - Drop Shadow Methods

+ (void)startDropShadow:(CGSize)offset andBlur:(float)blur
{
    [self startDropShadow:offset andBlur:blur andColor:[UIColor blackColor]];
}

+ (void)startDropShadow:(CGSize)offset andBlur:(float)blur andColor:(UIColor *)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, offset, blur, color.CGColor);
}

+ (void)endShadow
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextRestoreGState(context);
}

#pragma mark - Path Methods

+ (CGPathRef)newPathWithRect:(CGRect)rect
{
    CGMutablePathRef p = CGPathCreateMutable();

    CGPathMoveToPoint(p, NULL, rect.origin.x, rect.origin.y);
    CGPathAddLineToPoint(p, NULL, rect.origin.x, rect.origin.y + rect.size.height);
    CGPathAddLineToPoint(p, NULL, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGPathAddLineToPoint(p, NULL, rect.origin.x + rect.size.width, rect.origin.y);
    CGPathAddLineToPoint(p, NULL, rect.origin.x, rect.origin.y);

    CGPathCloseSubpath(p);

    return p;
}

+ (CGPathRef)newPathForCircle:(CGRect)rect
{
    CGMutablePathRef p = CGPathCreateMutable();
    CGPathAddEllipseInRect(p, nil, rect);
    CGPathCloseSubpath(p);
    return p;
}

+ (CGPathRef)newPathWithTriangle:(Triangle)triangle
{
    CGMutablePathRef p = CGPathCreateMutable();

    CGPathMoveToPoint(p, NULL, triangle.a.x, triangle.a.y);
    CGPathAddLineToPoint(p, NULL, triangle.b.x, triangle.b.y);
    CGPathAddLineToPoint(p, NULL, triangle.c.x, triangle.c.y);
    CGPathAddLineToPoint(p, NULL, triangle.a.x, triangle.a.y);

    CGPathCloseSubpath(p);

    return p;
}

+ (CGPathRef)newRoundedCornerPathWithRect:(CGRect)rect andRadius:(float)radius
{
    return [self newRoundedCornerPathWithRect:rect radius:radius andCorners:UIRectCornerAllCorners];
}

+ (CGPathRef)newRoundedCornerPathWithRect:(CGRect)rect radius:(float)radius andCorners:(UIRectCorner)corners;
{
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)].CGPath;
    CGPathRetain(path);
    return path;
}

#pragma mark - Gradient Methods

+ (void)drawVerticalGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor inRect:(CGRect)rect
{
    [self drawGradientWithStartColor:startColor endColor:endColor inRect:rect
                                   fromPoint:CGPointMake(0.0, rect.origin.y)
                                   toPoint:CGPointMake(0.0, rect.origin.y + rect.size.height)];
}

+ (void)drawHorizontalGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor inRect:(CGRect)rect
{
    [self drawGradientWithStartColor:startColor endColor:endColor inRect:rect
                                   fromPoint:CGPointMake(rect.origin.x, rect.origin.y)
                                     toPoint:CGPointMake(rect.origin.x + rect.size.width, rect.origin.y)];
}

+ (void)drawGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor inRect:(CGRect)rect fromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient = [UIView newGradientWithStart:startColor andEnd:endColor];

    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
}

+ (CGGradientRef)newGradientWithStart:(UIColor *)startColor andEnd:(UIColor *)endColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGColorSpaceRef colorspace = CGBitmapContextGetColorSpace(context);

    CGFloat locations[2] = {0.0, 1.0};

    CGColorRef colorRefs[] = {startColor.CGColor, endColor.CGColor};
    CFArrayRef colorArray = CFArrayCreate(NULL, (const void**)colorRefs, sizeof(colorRefs) / sizeof(CGColorRef), &kCFTypeArrayCallBacks);

    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, colorArray, locations);
    CFRelease(colorArray);

    return gradient;
}

@end
