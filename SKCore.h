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

#define WEAKIFY(var, weakName) __weak typeof(var) weakName = (var);
#define WEAKIFY_SELF(weakName) __weak typeof(self) weakName = (self);
#define STRONGIFY(weakVar, strongName) __strong typeof(weakVar) strongName = (weakVar);
#define SAFE_STRONGIFY(weakVar, strongName) __strong typeof(weakVar) strongName = (weakVar); if (strongName == nil) { return; };

// -- Util

#import "NSString+SKCore.h"
#import "UIDevice+SKCore.h"
#import "SKLogger.h"

// -- View

#import "SKShapeTypes.h"
#import "UIColor+SKCore.h"
#import "UIImage+SKCore.h"
#import "UIView+SKDrawing.h"
#import "UIView+SKFrame.h"
#import "NSObject+SKAutoLayout.h"
#import "UIView+SKAutoLayout.h"
#import "UIViewController+Children.h"
#import "SKView.h"
