    /*
     * Copyright (c) 2013 MeetMe, Inc.
     * All rights reserved.
     *
     * Redistribution and use in source and binary forms, with or without
     * modification, are permitted provided that the following conditions are met:
     * 1. Redistributions of source code must retain the above copyright
     *   notice, this list of conditions and the following disclaimer.
     * 2. Redistributions in binary form must reproduce the above copyright
     *   notice, this list of conditions and the following disclaimer in the
     *   documentation and/or other materials provided with the distribution.
     * 3. Neither the name of the MeetMe Inc. nor the
     *   names of its contributors may be used to endorse or promote products
     *   derived from this software without specific prior written permission.
     *
     * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
     * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
     * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
     * DISCLAIMED. IN NO EVENT SHALL MeetMe Inc. BE LIABLE FOR ANY
     * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
     * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
     * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
     * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
     * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
     * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
     */


SKCore
=======

####Core of SimpleKit full of useful tools for making code less verbose and easier to understand.

------------

Controller
------------

**SKAnimatedVC**: Subclass of UIViewController with the ability to easily animate the adding and removal of child view controllers. Animations are all based on a direction of movement and a different direction can be set for addition and removal.

* **Up** : Moves the controller up
* **Down** : Moves the controller down
* **Left** : Moves the controller to the left
* **Right** : Moves the controller to the right
* **In**: Moves in from a defined rect
* **Out**: Moves in from a defined rect

**UIViewController+Children**: Category to simplify the code needed to add and remove child view controllers.

Drawing
------------

**SKShapeTypes**: Collection of types used to simplify drawing specific shapes.

**SKView**: UIView subclass to simplify custom drawing in a view. Has a block property that hooks into -drawRect: so drawing can be inline with view creation instead of being forced to create a subclass.

**UIColor+SKCore**: UIColor category to simplify color creation. +randomColor is a method that is very helpful when used for debugging layout. +colorWithHex: will allow you to define a color based on a hex value. Hex values must also include alpha.

* 75% white - 0xBFFFFFFF
* 60% black - 0x99000000

**UIImage+SKCore**: UIImage category for manipulating a UIImage.

* Flipping
* Rotating
* Getting individual pixel values
* Get NSData of an image
* Add a glow
* Create and image based on a UIColor

**UIView+SKDrawing**: UIView category with helpful wrappers around CoreGraphics.

* Draw rectangles
* Draw rounded rectanlges
* Draw ovals
* Draw circles
* Draw triangles
* Draw custom shapes based on a path
* Draw borders on a shape
* Clip a drawing
* Add a drop shadow
* Draw a gradient

Layout
------------

**NSObject+SKAutoLayout**: Category on NSObject used to allow any object to create and manage a set of constraints.

**UIView+SKAutoLayout**: Category on UIView that simplifies creating auto layout constraints.

**UIView+SKFrame**: Category on UIView that simplifies access to frame values.

Util
------------

**NSAttributedString+SKHTML**: Category on NSAttributedString that can create an attributed string from and HTML string.

**NSString+SKCore**: Category on NSString to simplify manipulating a string or checking its validity.

**SKLogger**: Class used to get access to device logs created with NSLog for display within an app.

**UIDevice+SKCore**: Category on UIDevice for getting information about the current device.

