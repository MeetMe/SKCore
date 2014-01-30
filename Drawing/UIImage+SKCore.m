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
#import "UIImage+SKCore.h"
#import "UIView+SKDrawing.h"

static CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};

@implementation UIImage (Extra)

- (UIImage *)addGlow
{
    CGSize oldSize = self.size;

    float size = 6.0;
    float halfSize = size/2.0;

    CGRect newRect = CGRectMake(-halfSize, -halfSize, oldSize.width + size, oldSize.height + size);
    CGImageRef cgImage = self.CGImage;

    UIGraphicsBeginImageContext(newRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, newRect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), 3.0, [UIColor whiteColor].CGColor);

    CGPathRef path = [UIView newRoundedCornerPathWithRect:CGRectMake(halfSize/2.0,
                                                                     halfSize/2.0,
                                                                     newRect.size.width - halfSize,
                                                                     newRect.size.height - halfSize) andRadius:4.0];

    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextDrawPath(context, kCGPathFill);
    CGContextRestoreGState(context);

    // draw the original image into the context, offset to be centered;
    CGRect centerRect = CGRectMake(halfSize, halfSize, oldSize.width, oldSize.height);
    CGContextDrawImage(context, centerRect, cgImage);

    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return result;
}

- (NSData *)jpegData:(CGFloat)quality
{
    return UIImageJPEGRepresentation(self, quality);
}

- (UIImage *)flippedX:(BOOL)flipX flippedY:(BOOL)flipY
{
    UIEdgeInsets currentInsets = self.capInsets;
    CGSize newSize = CGSizeMake(truncf(self.size.width), truncf(self.size.height));

    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();

    // -- Apply Transformation

    if (flipX && !flipY)
    {
        CGContextTranslateCTM(context, newSize.width, newSize.height);
        CGContextScaleCTM(context, -1.0f, -1.0);
    }
    else if (flipX && flipY)
    {
        CGContextTranslateCTM(context, newSize.width, 0.0);
        CGContextScaleCTM(context, -1.0f, 1.0);
    }
    else if (!flipX && flipY)
    {
        CGContextTranslateCTM(context, 0.0, newSize.height);
        CGContextScaleCTM(context, 1.0f, -1.0);
    }

    // -- Draw Image

    CGContextDrawImage(context, CGRectMake(0.0, 0.0, newSize.width, newSize.height), self.CGImage);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIEdgeInsets invertedInsets = currentInsets;

    if (flipX)
    {
        invertedInsets = UIEdgeInsetsMake(currentInsets.top,
                                          currentInsets.right,
                                          currentInsets.bottom,
                                          currentInsets.left);
    }
    else if (flipY)
    {
        invertedInsets = UIEdgeInsetsMake(currentInsets.bottom,
                                          currentInsets.left,
                                          currentInsets.top,
                                          currentInsets.right);
    }

    image = [image resizableImageWithCapInsets:invertedInsets resizingMode:UIImageResizingModeStretch];
    UIGraphicsEndImageContext();

    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+ (UIImage *)alwaysOriginalImageNamed:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    if ([UIDevice iOS7Plus])
    {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return image;
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;

    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();

    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);

    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));

    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIColor *)getPixelColorAtLocation:(CGPoint)point
{
    point = CGPointMake(point.x*[UIScreen mainScreen].scale, point.y*[UIScreen mainScreen].scale);
    UIColor *color = nil;
    CGImageRef cgImage = self.CGImage;
    CGContextRef context = [self newOnePixelARGBBitmapContext];

    if (context == NULL)
    {
        return nil; /* error */
    }

    size_t w = CGImageGetWidth(cgImage);
    size_t h = CGImageGetHeight(cgImage);

    point = CGPointMake(w - point.x, point.y);
    CGRect rect = {{point.x - w, point.y - h}, {w, h}};

    CGContextDrawImage(context, rect, cgImage);

    unsigned char* data = CGBitmapContextGetData(context);

    if (data != NULL)
    {
        int alpha =  data[0];
        int red = data[1];
        int green = data[2];
        int blue = data[3];

        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
    }

    CGContextRelease(context);

    if (data)
    {
        free(data);
    }

    return color;
}

- (CGContextRef)newOnePixelARGBBitmapContext
{
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    void *bitmapData;
    int bitmapByteCount;
    int bitmapBytesPerRow;

    size_t pixelsWide = 1;
    size_t pixelsHigh = 1;

    bitmapBytesPerRow = (int)(pixelsWide * 4);
    bitmapByteCount = (int)(bitmapBytesPerRow * pixelsHigh);

    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
    {
        return NULL;
    }

    bitmapData = malloc(bitmapByteCount);

    if (bitmapData == NULL)
    {
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }

    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free(bitmapData);
    }

    CGColorSpaceRelease(colorSpace);

    return context;
}

#pragma mark - Image Drawing

+ (void)beginImageContextWithSize:(CGSize)imageSize
{
    [self beginImageContextWithSize:imageSize opaque:NO scale:[UIScreen mainScreen].scale];
}

+ (void)beginOpaqueImageContextWithSize:(CGSize)imageSize
{
    [self beginImageContextWithSize:imageSize opaque:YES scale:[UIScreen mainScreen].scale];
}

+ (void)beginImageContextWithSize:(CGSize)imageSize opaque:(BOOL)opaque scale:(CGFloat)scale
{
    UIGraphicsBeginImageContextWithOptions(imageSize, opaque, scale);
}

+ (UIImage *)endImageContext
{
    UIImage *endImage = [UIGraphicsGetImageFromCurrentImageContext() copy];
    UIGraphicsEndImageContext();
    return endImage;
}

@end
