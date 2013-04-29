//
//  FCBasicAnimationFactory.h
//  FCEasingAnimation
//

/*
 
 Created by Felix Chern on 12/10/18.
 Copyright (c) 2012 Felix R. Chern. All rights reserved. (BSD LICENSE)
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 * Neither the name of the FCAnimationFactory nor the
 names of its contributors may be used to endorse or promote products
 derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL FELIX R. CHERN BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */


#import <Foundation/Foundation.h>
#import "FCAnimationFactory.h"

@interface FCBasicAnimationFactory : FCAnimationFactory <NSCopying>
{
    NSArray* _normalizedValues;
    id _fromValue;
    id _toValue;
}
@property (nonatomic, copy) NSArray* normalizedValues;
@property (nonatomic, retain) id fromValue;
@property (nonatomic, retain) id toValue;

+ (CAKeyframeAnimation*) animationWithName:(NSString*)name fromValue:(id)fv toValue: (id)tv duration:(NSNumber*)duration;

extern NSString * const kFCEasingAnimationNameLinear;

extern NSString * const kFCEasingAnimationNameQuadraticEaseIn;
extern NSString * const kFCEasingAnimationNameQuadraticEaseOut;
extern NSString * const kFCEasingAnimationNameQuadraticEaseInOut;

extern NSString * const kFCEasingAnimationNameCubicEaseIn;
extern NSString * const kFCEasingAnimationNameCubicEaseOut;
extern NSString * const kFCEasingAnimationNameCubicEaseInOut;

extern NSString * const kFCEasingAnimationNameQuarticEaseIn;
extern NSString * const kFCEasingAnimationNameQuarticEaseOut;
extern NSString * const kFCEasingAnimationNameQuarticEaseInOut;

extern NSString * const kFCEasingAnimationNameQuinticEaseIn;
extern NSString * const kFCEasingAnimationNameQuinticEaseOut;
extern NSString * const kFCEasingAnimationNameQuinticEaseInOut;

extern NSString * const kFCEasingAnimationNameSineEaseIn;
extern NSString * const kFCEasingAnimationNameSineEaseOut;
extern NSString * const kFCEasingAnimationNameSineEaseInOut;

extern NSString * const kFCEasingAnimationNameCircularEaseIn;
extern NSString * const kFCEasingAnimationNameCircularEaseOut;
extern NSString * const kFCEasingAnimationNameCircularEaseInOut;

extern NSString * const kFCEasingAnimationNameExpEaseIn;
extern NSString * const kFCEasingAnimationNameExpEaseOut;
extern NSString * const kFCEasingAnimationNameExpEaseInOut;

extern NSString * const kFCEasingAnimationNameElasticEaseIn;
extern NSString * const kFCEasingAnimationNameElasticEaseOut;

extern NSString * const kFCEasingAnimationNameBackEaseIn;
extern NSString * const kFCEasingAnimationNameBackEaseOut;

extern NSString * const kFCEasingAnimationNameBounceEaseIn;
extern NSString * const kFCEasingAnimationNameBounceEaseOut;


@end
