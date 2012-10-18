//
//  FCBaseFactoryTests.m
//  FCEasingAnimation
//
//  Created by 陳仁乾 on 12/10/18.
//  Copyright (c) 2012年 dryman. All rights reserved.
//

#import "FCBaseFactoryTests.h"


@implementation FCBaseFactoryTests

- (void)setUp
{
    [super setUp];
    factory = [[FCValueAnimationFactory alloc] init];
}

- (void)testDefaultFactory_timingFunctionCount
{
    CAKeyframeAnimation *animation = [factory animation];
    NSArray *timingFunctions = animation.timingFunctions;
    STAssertEquals(timingFunctions.count, 1U, @"only one function here");
}

- (void)testDefaultFactory_timingFunction
{
    CAKeyframeAnimation *animation = [factory animation];
    NSArray *timingFunctions = animation.timingFunctions;
    CAMediaTimingFunction *tFunc = [timingFunctions objectAtIndex:0];
    
    float c0[2];
    [tFunc getControlPointAtIndex:0 values:c0];
    STAssertEqualsWithAccuracy(c0[0], 0.f, 0.00001f, @"c0[0] should be 0");
    STAssertEqualsWithAccuracy(c0[1], 0.f, 0.00001f, @"c0[1] should be 0");

    
    float c1[2], c2[2];
    [tFunc getControlPointAtIndex:1 values:c1];
    [tFunc getControlPointAtIndex:2 values:c2];
    
    STAssertEqualsWithAccuracy(c1[0], 0.f, 0.000001f, @"c1=(0,0)");
    STAssertEqualsWithAccuracy(c1[1], 0.f, 0.000001f, @"c1=(0,0)");
    STAssertEqualsWithAccuracy(c2[0], 1.f, 0.000001f, @"c2=(1,1)");
    STAssertEqualsWithAccuracy(c2[1], 1.f, 0.000001f, @"c2=(1,1)");
}

- (void)testDurationToSegmentCounts
{
    factory.totalDuration = [NSNumber numberWithFloat:1.f];
    CAKeyframeAnimation *animation = [factory animation];
    NSArray *timingFunctions = animation.timingFunctions;
    STAssertEquals(timingFunctions.count, 2U, @"two functions");
}

- (void)testTwoSegment_timingFunction
{
    factory.totalDuration = [NSNumber numberWithFloat:1.f];
    CAKeyframeAnimation *animation = [factory animation];
    NSArray *timingFunctions = animation.timingFunctions;
    for (CAMediaTimingFunction *tFunc in timingFunctions) {
        float c0[2];
        [tFunc getControlPointAtIndex:0 values:c0];
        STAssertEqualsWithAccuracy(c0[0], 0.f, 0.00001f, @"c0[0] should be 0");
        STAssertEqualsWithAccuracy(c0[1], 0.f, 0.00001f, @"c0[1] should be 0");
        
        
        float c1[2], c2[2];
        [tFunc getControlPointAtIndex:1 values:c1];
        [tFunc getControlPointAtIndex:2 values:c2];
        
        STAssertEqualsWithAccuracy(c1[0], 0.f, 0.000001f, @"c1=(0,0)");
        STAssertEqualsWithAccuracy(c1[1], 0.f, 0.000001f, @"c1=(0,0)");
        STAssertEqualsWithAccuracy(c2[0], 1.f, 0.000001f, @"c2=(1,1)");
        STAssertEqualsWithAccuracy(c2[1], 1.f, 0.000001f, @"c2=(1,1)");
    }
}

- (void)testQuintFunction
{
    factory.totalDuration = [NSNumber numberWithFloat:1.f];
    factory.timingBlocks = [NSArray arrayWithObject:^float(float x){
        return x*x*x*x*x;
    }];
    CAKeyframeAnimation *animation = [factory animation];
    CAMediaTimingFunction *tFunc0 = [animation.timingFunctions objectAtIndex:0];
    CAMediaTimingFunction *tFunc1 = [animation.timingFunctions objectAtIndex:1];
    
    float c1[2], c2[2];
    [tFunc0 getControlPointAtIndex:1 values:c1];
    [tFunc0 getControlPointAtIndex:2 values:c2];
    
    STAssertEqualsWithAccuracy(c1[0], 0.249994f, 0.0001f, @"c1=(0.25,0)");
    STAssertEqualsWithAccuracy(c1[1],       0.f, 0.0001f, @"c1=(0.25,0)");
    STAssertEqualsWithAccuracy(c2[0],     0.75f, 0.0001f, @"c2=(0.75,-0.25)");
    STAssertEqualsWithAccuracy(c2[1],    -0.25f, 0.0001f, @"c2=(0.75,-0.25)"); // won't it blowup when we render it?
    
    [tFunc1 getControlPointAtIndex:1 values:c1];
    [tFunc1 getControlPointAtIndex:2 values:c2];
    
    STAssertEqualsWithAccuracy(c1[0], 0.31667f, 0.0001f, @"c1=(0,0)");
    STAssertEqualsWithAccuracy(c1[1], 0.05107f, 0.0001f, @"c1=(0,0)");
    STAssertEqualsWithAccuracy(c2[0], 0.68333f, 0.0001f, @"c2=(1,1)");
    STAssertEqualsWithAccuracy(c2[1], 0.18279f, 0.0001f, @"c2=(1,1)");
}

- (void)testTwoTimingFunctions
{
    factory.totalDuration = [NSNumber numberWithFloat:1.f];
    factory.normalizedTimings = [NSArray arrayWithObjects:@0.f, @.5f, @1.f, nil];
    factory.timingBlocks = [NSArray arrayWithObjects:
                            ^float(float x){
                                return  x*x;
                            },
                            ^float(float x){
                                return -x*x + 2*x;
                            },
                            nil];
    factory.normalizedValues = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0.f],
                                [NSNumber numberWithFloat:0.5f],
                                [NSNumber numberWithFloat:1.f], nil];
    
    CAKeyframeAnimation *animation = [factory animation];
    NSArray *timingFunctions = animation.timingFunctions;
    STAssertEqualsWithAccuracy((float)animation.duration, 1.f, 0.0001f, @"duration is 1s");
    STAssertEquals(timingFunctions.count, 2U, @"two functions");

    CAMediaTimingFunction *tFunc0 = [timingFunctions objectAtIndex:0];
    CAMediaTimingFunction *tFunc1 = [timingFunctions objectAtIndex:1];
    

    float c1[2], c2[2];
    [tFunc0 getControlPointAtIndex:1 values:c1];
    [tFunc0 getControlPointAtIndex:2 values:c2];
    
    STAssertEqualsWithAccuracy(c1[0], 0.33334f, 0.0001f, @"c1=(0,0)");
    STAssertEqualsWithAccuracy(c1[1],      0.f, 0.0001f, @"c1=(0,0)");
    STAssertEqualsWithAccuracy(c2[0], 0.66666f, 0.0001f, @"c2=(1,1)");
    STAssertEqualsWithAccuracy(c2[1], 0.33333f, 0.0001f, @"c2=(1,1)");
    
    // Bug!!!
    [tFunc1 getControlPointAtIndex:1 values:c1];
    [tFunc1 getControlPointAtIndex:2 values:c2];
    
    STAssertEqualsWithAccuracy(c1[0], 0.33333f, 0.0001f, @"c1=(0,0)");
    STAssertEqualsWithAccuracy(c1[1], 0.66666f, 0.0001f, @"c1=(0,0)");
    STAssertEqualsWithAccuracy(c2[0], 0.66666f, 0.0001f, @"c2=(1,1)");
    STAssertEqualsWithAccuracy(c2[1],      1.f, 0.0001f, @"c2=(1,1)");
}

@end