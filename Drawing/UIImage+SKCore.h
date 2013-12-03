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

#define SK_LOCAL_IMAGE(_PATH) [UIImage imageWithContentsOfFile:_PATH]

/**
 * Category for common image manipulation methods
 *
 * @author Jed Laudenslayer
 */
@interface UIImage (Extra)

/**
 * Add an outer glow to a UIImage.
 *
 * @return The image with a glow applied.
 */
- (UIImage *)addGlow;

/**
 * Get UIImage as JPEG NSData.
 *
 * @param quality 0.0-1.0 low-high
 * @return The NSData representation.
 */
- (NSData *)jpegData:(CGFloat)quality;

/**
 * Create a copy of the image horizontally flipped.
 *
 * @return The flipped UIImage
 */
- (UIImage *)flippedX:(BOOL)flipX flippedY:(BOOL)flipY;

/**
 * Create a UIImage with a specific color.
 *
 * @param color The color to create the image from.
 * @return The image created with the color.
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 * Convenience method to load an image with the imageNamed: method and then set the
 * image rendering mode to UIImageRenderingModeAlwaysOriginal. This simplifies some
 * issues on iOS7 where the UIImageRenderingModeAutomatic sometimes incorrectly assumes
 * that the image is a template and tints the image.
 *
 * @param name The name of the file. If this is the first time the image is being loaded,
 * the method looks for an image with the specified name in the application’s main bundle.
 * @return The image object for the specified file, or nil if the method could not find the specified image.
 */
+ (UIImage *)alwaysOriginalImageNamed:(NSString *)name;

/**
 * Rotate a UIImage by a specific degree.
 *
 * @param degrees The degrees by which to rotate.
 * @return The rotated image.
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 * Get the color of a pixel at a specific location.
 *
 * @param point The point to get the color from.
 * @return The color of the pixel.
 */
- (UIColor *)getPixelColorAtLocation:(CGPoint)point;

#pragma mark - Image Drawing

/**
 * Begin an image context with a specific size.
 *
 * @param imageSize The size of the image you want to create.
 */
+ (void)beginImageContextWithSize:(CGSize)imageSize;

/**
 * Begin an image context with a specific size.
 *
 * @param imageSize The size of the image you want to create.
 */
+ (void)beginOpaqueImageContextWithSize:(CGSize)imageSize;

/**
 * Begin an image context access to all underlying parameters.
 *
 * @param imageSize The size of the image you want to create.
 * @param opaque Should the image be opaque.
 * @param scale The scale to use for the image.
 */
+ (void)beginImageContextWithSize:(CGSize)imageSize opaque:(BOOL)opaque scale:(CGFloat)scale;

/**
 * End the image context. Must be called after one of the above methods.
 *
 * @return The image created by the current image context.
 */
+ (UIImage *)endImageContext;

@end