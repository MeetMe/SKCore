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

