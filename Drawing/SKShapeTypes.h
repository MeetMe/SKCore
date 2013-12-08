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
 * This is a collection of Structs used for the creation of shapes.
 *
 * @author Jed Laudenslayer
 */

typedef enum
{
    RectIndexTop = 0,
    RectIndexRight,
    RectIndexBottom,
    RectIndexLeft,
} RectIndex;

//! Struct used to pass the border sizes for a rectangle.
typedef struct _RectBorders
{
    CGFloat top;
    CGFloat right;
    CGFloat bottom;
    CGFloat left;
} RectBorders;

/**
 * Helper macro that creates an _RectBorders type
 *
 * @param t Size for the top border.
 * @param r Size for the right border.
 * @param b Size for the bottom border.
 * @param l Size for the left border.
 */
static inline RectBorders
RectBordersMake(const CGFloat t, const CGFloat r, const CGFloat b, const CGFloat l)
{
    RectBorders borders = {t, r, b, l};
    return borders;
}

//! No rectangle borders
static const RectBorders RectBordersZero = {0, 0, 0, 0};

/**
 * Helper macro that creates an array of colors
 *
 * @param t Color for the top border.
 * @param r Color for the right border.
 * @param b Color for the bottom border.
 * @param l Color for the left border.
 * @return NSArray of border colors.
 */
static inline NSArray *
RectBorderColorsMake(const id t, const id r, const id b, const id l)
{
    id top = t != nil ? t : [NSNull null];
    id right = r != nil ? r : [NSNull null];
    id bottom = b != nil ? b : [NSNull null];
    id left = l != nil ? l : [NSNull null];

    return [NSArray arrayWithObjects:top, right, bottom, left, nil];
}

//! Struct used to pass the border sizes for a triangle.
typedef struct _TriBorders
{
    CGFloat a;
    CGFloat b;
    CGFloat c;
} TriBorders;

/**
 * Helper macro that creates a _TriBorders type
 *
 * @param a Side a of the triangle.
 * @param b Side b of the triangle.
 * @param c Side c of the triangle.
 * @return TriBorders
 */
static inline TriBorders
TriBordersMake(const CGFloat a, const CGFloat b, const CGFloat c)
{
    TriBorders borders = {a, b, c};
    return borders;
}

//! No triangle borders
static const TriBorders TriBordersZero = {0, 0, 0};

//! Struct used to pass the points that define a Triangle
typedef struct _Triangle
{
    CGPoint a;
    CGPoint b;
    CGPoint c;
} Triangle;

/**
 * Helper macro that creates an _Triangle type
 *
 * @param a Point a for the triangle.
 * @param b Point b for the triangle.
 * @param c Point c for the triangle.
 * @return Triangle
 */
static inline Triangle
TriangleMake(const CGPoint a, const CGPoint b, const CGPoint c)
{
    Triangle triangle = {a, b, c};
    return triangle;
}

//! No triangle
static const Triangle TriangleZero = {{0.0, 0.0}, {0.0, 0.0}, {0.0, 0.0}};
