//
//  FCBasicAnimationFactory.m
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

#import "FCBasicAnimationFactory.h"


NSString * const kFCEasingAnimationNameLinear =             @"linear";

NSString * const kFCEasingAnimationNameQuadraticEaseIn =    @"quadraticEaseIn";
NSString * const kFCEasingAnimationNameQuadraticEaseOut =   @"quadraticEaseOut";
NSString * const kFCEasingAnimationNameQuadraticEaseInOut = @"quadraticEaseInOut";

NSString * const kFCEasingAnimationNameCubicEaseIn =        @"cubicEaseIn";
NSString * const kFCEasingAnimationNameCubicEaseOut =       @"cubicEaseOut";
NSString * const kFCEasingAnimationNameCubicEaseInOut =     @"cubicEaseInOut";

NSString * const kFCEasingAnimationNameQuarticEaseIn =      @"quarticEaseIn";
NSString * const kFCEasingAnimationNameQuarticEaseOut =     @"quarticEaseOut";
NSString * const kFCEasingAnimationNameQuarticEaseInOut =   @"quarticEaseInOut";

NSString * const kFCEasingAnimationNameQuinticEaseIn =      @"quinticEaseIn";
NSString * const kFCEasingAnimationNameQuinticEaseOut =     @"quinticEaseOut";
NSString * const kFCEasingAnimationNameQuinticEaseInOut =   @"quinticEaseInOut";

NSString * const kFCEasingAnimationNameSineEaseIn =         @"sineEaseIn";
NSString * const kFCEasingAnimationNameSineEaseOut =        @"sineEaseOut";
NSString * const kFCEasingAnimationNameSineEaseInOut =      @"sineEaseInOut";

NSString * const kFCEasingAnimationNameCircularEaseIn =     @"circularEaseIn";
NSString * const kFCEasingAnimationNameCircularEaseOut =    @"circularEaseOut";
NSString * const kFCEasingAnimationNameCircularEaseInOut =  @"circularEaseInOut";

NSString * const kFCEasingAnimationNameExpEaseIn =          @"expEaseIn";
NSString * const kFCEasingAnimationNameExpEaseOut =         @"expEaseOut";
NSString * const kFCEasingAnimationNameExpEaseInOut =       @"expEaseInOut";

NSString * const kFCEasingAnimationNameElasticEaseIn =      @"elasticEaseIn";
NSString * const kFCEasingAnimationNameElasticEaseOut =     @"elasticEaseOut";

NSString * const kFCEasingAnimationNameBackEaseIn =         @"backEaseIn";
NSString * const kFCEasingAnimationNameBackEaseOut =        @"backEaseOut";

NSString * const kFCEasingAnimationNameBounceEaseIn =       @"bounceEaseIn";
NSString * const kFCEasingAnimationNameBounceEaseOut =      @"bounceEaseOut";


@implementation FCBasicAnimationFactory
@synthesize normalizedValues = _normalizedValues;
@synthesize fromValue = _fromValue;
@synthesize toValue = _toValue;


-(FCBasicAnimationFactory*)init
{
    if (self=[super init]) {
        _normalizedValues = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.f],
                             [NSNumber numberWithFloat:1.f], nil];
        _fromValue = [NSNumber numberWithFloat:0.f];
        _toValue = [NSNumber numberWithFloat:1.f];
    }
    return self;
}

+ (CAKeyframeAnimation*) animationWithName:(NSString*)name
                                 fromValue:(id)fv
                                   toValue: (id)tv
                                  duration:(NSNumber*)duration
{
    FCBasicAnimationFactory *factory = [[FCBasicAnimationFactory animationDictionary] valueForKey:name];
    factory.fromValue = fv;
    factory.toValue = tv;
    factory.totalDuration = duration;
    return [factory animation];
}

- (id)copyWithZone:(NSZone *)zone
{
    FCBasicAnimationFactory *factoryCopy = [[FCBasicAnimationFactory allocWithZone:zone] init];
    factoryCopy.normalizedTimings = _normalizedTimings;
    factoryCopy.timingBlocks = _timingBlocks;
    factoryCopy.totalDuration = _totalDuration;
    factoryCopy.normalizedValues = _normalizedValues;
    factoryCopy.fromValue = _fromValue;
    factoryCopy.toValue = _toValue;
    return factoryCopy;
}

+ (NSDictionary *)animationDictionary
{
    static NSMutableDictionary* dict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dict==nil) {
            dict = [[NSMutableDictionary alloc] init];
            float(^quadraticEaseIn)(float)  = ^(float x){return x*x;};
            float(^cubicEaseIn)(float)      = ^(float x){return x*x*x;};
            float(^quarticEaseIn)(float)    = ^(float x){return x*x*x*x;};
            float(^quinticEaseIn)(float)    = ^(float x){return x*x*x*x*x;};
            float(^quadraticEaseOut)(float) = ^(float x){return 1.f -(x-1.f)*(x-1.f);};
            float(^cubicEaseOut)(float)     = ^(float x){return 1.f +(x-1.f)*(x-1.f)*(x-1.f);};
            float(^quarticEaseOut)(float)   = ^(float x){return 1.f -(x-1.f)*(x-1.f)*(x-1.f)*(x-1.f);};
            float(^quinticEaseOut)(float)   = ^(float x){return 1.f +(x-1.f)*(x-1.f)*(x-1.f)*(x-1.f)*(x-1.f);};
            float(^sineEaseIn)(float)       = ^(float x){return sinf((x-1.f) * M_PI_2) + 1;};
            float(^sineEaseOut)(float)      = ^(float x){return sinf(x*M_PI_2);};
            
            
            float(^circularEaseIn)(float)   = ^(float x){return 1.f - sqrtf(1.f - x*x);};
            float(^circularEaseOut)(float)  = ^(float x){return sqrtf((2.f - x)*x);};
            float(^expEaseIn)(float)        = ^(float x){return powf(2.f, 10.f * (x-1));};
            float(^expEaseOut)(float)       = ^(float x){return 1.f - powf(2.f, -10.f * x);};
            float(^elasticEaseIn)(float)    = ^(float x){return sinf(13.f * M_PI_2 * x) * powf(2.f, 10.f * (x-1.f));};
            float(^elasticEaseOut)(float)   = ^(float x){return sinf(-13.f * M_PI_2 * (x+1.f)) * powf(2.f, -10.f *x) + 1;};
            float(^backEaseIn)(float)       = ^(float x){return x*x*x - x * sinf(x * M_PI);};
            float(^backEaseOut)(float)      = ^(float x){float f = (1.f-x); return 1.f - (f*f*f - f * sinf(f * M_PI));};
            
            float(^bounceEaseOut)(float) = ^(float x) {
                if (x < 1.f/2.75f) {
                    return 7.5625f*x*x;
                } else if (x < 2.0f/2.75f) {
                    x -= 1.5f/2.75f;
                    return 7.5625f*x*x + .75f;
                } else if (x < 2.5f/2.75f) {
                    x -= 2.25f/2.75f;
                    return 7.5625f*x*x + .9375f;
                } else {
                    x -= 2.625f/2.75f;
                    return 7.5625f*x*x + .984375f;
                }
            };
            float(^bounceEaseIn)(float) = ^(float x) { return 1.0f - bounceEaseOut(x); };
            
            
            /* one step animations */
            FCBasicAnimationFactory* factory = [[FCBasicAnimationFactory alloc] init];
            factory.normalizedValues = [NSArray arrayWithObjects:
                                        [NSNumber numberWithFloat:0.f],
                                        [NSNumber numberWithFloat:1.f], nil];
            factory.normalizedTimings = [NSArray arrayWithObjects:
                                         [NSNumber numberWithFloat:0.f],
                                         [NSNumber numberWithFloat:1.f], nil];
            
            factory.timingBlocks = [NSArray arrayWithObject:^(float x){return x;}];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameLinear];
            
            factory.timingBlocks = [NSArray arrayWithObject:quadraticEaseIn];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameQuadraticEaseIn];
            factory.timingBlocks = [NSArray arrayWithObject:quadraticEaseOut];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameQuadraticEaseOut];
            
            factory.timingBlocks = [NSArray arrayWithObject:cubicEaseIn];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameCubicEaseIn];
            factory.timingBlocks = [NSArray arrayWithObject:cubicEaseOut];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameCubicEaseOut];
            
            factory.timingBlocks = [NSArray arrayWithObject:quarticEaseIn];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameQuarticEaseIn];
            factory.timingBlocks = [NSArray arrayWithObject:quarticEaseOut];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameQuarticEaseOut];
            
            factory.timingBlocks = [NSArray arrayWithObject:quinticEaseIn];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameQuinticEaseIn];
            factory.timingBlocks = [NSArray arrayWithObject:quinticEaseOut];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameQuinticEaseOut];
            
            factory.timingBlocks = [NSArray arrayWithObject:sineEaseIn];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameSineEaseIn];
            factory.timingBlocks = [NSArray arrayWithObject:sineEaseOut];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameSineEaseOut];
            
            factory.timingBlocks = [NSArray arrayWithObject:circularEaseIn];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameCircularEaseIn];
            factory.timingBlocks = [NSArray arrayWithObject:circularEaseOut];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameCircularEaseOut];
            
            factory.timingBlocks = [NSArray arrayWithObject:expEaseIn];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameExpEaseIn];
            factory.timingBlocks = [NSArray arrayWithObject:expEaseOut];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameExpEaseOut];
            
            factory.timingBlocks = [NSArray arrayWithObject:elasticEaseIn];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameElasticEaseIn];
            factory.timingBlocks = [NSArray arrayWithObject:elasticEaseOut];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameElasticEaseOut];
            
            factory.timingBlocks = [NSArray arrayWithObject:backEaseIn];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameBackEaseIn];
            factory.timingBlocks = [NSArray arrayWithObject:backEaseOut];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameBackEaseOut];
            
            factory.timingBlocks = [NSArray arrayWithObject:bounceEaseIn];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameBounceEaseIn];
            factory.timingBlocks = [NSArray arrayWithObject:bounceEaseOut];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameBounceEaseOut];

            
            /* two steps animations */
            factory.normalizedValues = [NSArray arrayWithObjects:
                                        [NSNumber numberWithFloat:0.f],
                                        [NSNumber numberWithFloat:0.5f],
                                        [NSNumber numberWithFloat:1.f], nil];
            factory.normalizedTimings = [NSArray arrayWithObjects:
                                         [NSNumber numberWithFloat:0.f],
                                         [NSNumber numberWithFloat:0.5f],
                                         [NSNumber numberWithFloat:1.f], nil];
            
            factory.timingBlocks = [NSArray arrayWithObjects: quadraticEaseIn, quadraticEaseOut, nil];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameQuadraticEaseInOut];
            
            factory.timingBlocks = [NSArray arrayWithObjects: cubicEaseIn, cubicEaseOut, nil];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameCubicEaseInOut];
            
            factory.timingBlocks = [NSArray arrayWithObjects: quarticEaseIn, quarticEaseOut, nil];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameQuarticEaseInOut];
            
            factory.timingBlocks = [NSArray arrayWithObjects: quinticEaseIn, quinticEaseOut, nil];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameQuinticEaseInOut];
            
            factory.timingBlocks = [NSArray arrayWithObjects: sineEaseIn, sineEaseOut, nil];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameSineEaseInOut];
            
            factory.timingBlocks = [NSArray arrayWithObjects: circularEaseIn, circularEaseOut, nil];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameCircularEaseInOut];
            
            factory.timingBlocks = [NSArray arrayWithObjects: expEaseIn, expEaseOut, nil];
            [dict setObject:[factory copy] forKey:kFCEasingAnimationNameExpEaseInOut];
        }

    });
    return dict;
}


- (CAKeyframeAnimation*) animation
{
    // TODO: assert if count of normalizedTimes, normalizedValues and timingFunctions is correct
    // TODO: need to implement different kinds of values...
    
        
    NSMutableArray *keyTimes = [NSMutableArray array];
    NSMutableArray *timingFunctions = [NSMutableArray array];
    NSMutableArray *values = [NSMutableArray array];
    float total_duration = self.totalDuration.floatValue;
    id (^scalingBlock)(float) = [self makeValueScalingBlockFromValue:self.fromValue ToValue:self.toValue];
    __block float time_accumulator = 0.f;
    
    // durations are much more convinient to do calculations!
    [self.durations enumerateObjectsUsingBlock:^(NSNumber* nsDuration, NSUInteger idx, BOOL *stop) {
        float (^block)(float) = [self.timingBlocks objectAtIndex:idx];
        float duration = nsDuration.floatValue;
        int count = (int)ceilf(duration*SEGMENT_FACTOR);
        float n_value0 = [[self.normalizedValues objectAtIndex:idx] floatValue];
        float n_value1 = [[self.normalizedValues objectAtIndex:idx+1] floatValue];
        float n_value_diff = n_value1 - n_value0;
        
        float time_step = duration/(float)count;
        float n_step = 1.f/(float)count; // normalized
        float n_iter = 0.f;
        
        float c1[2], c2[2];
        
        for (int i = 0; i<count; i++) {
            fc_bezier_interpolation(c1, c2, n_iter, n_iter+n_step, block);
            [timingFunctions addObject:[CAMediaTimingFunction functionWithControlPoints:c1[0] :c1[1] :c2[0] :c2[1]]];
            
            [keyTimes addObject:[NSNumber numberWithFloat:time_accumulator/total_duration]];
            
            float factor = block(n_iter)*n_value_diff + n_value0; // factor range is 0-1
            
            [values addObject:scalingBlock(factor)];
            
            n_iter += n_step;
            time_accumulator += time_step;
        }
    }];
    // last timestamp and value
    [keyTimes addObject:[NSNumber numberWithFloat:1.f]];
    [values addObject:self.toValue];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyTimes = keyTimes;
    animation.timingFunctions = timingFunctions;
    animation.duration = total_duration;
    animation.values = values;
    return animation;
}

@end
