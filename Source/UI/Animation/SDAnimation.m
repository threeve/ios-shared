//
//  SDAnimation.m
//
//  Derived by Steven Woolgar on 01/16/2014.
//  Changes Copyright 2014 SetDirection. All rights reserved.
//

/*
    PKRevealController > PKAnimation.m
    Copyright (c) 2013 zuui.org (Philip Kluz). All rights reserved.
 
    The MIT License (MIT)
 
    Copyright (c) 2013 Philip Kluz
 
    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
    the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:
 
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
 
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "SDAnimation.h"
#import "NSObject+SDBlocks.h"

@implementation SDAnimation

@synthesize layer = _layer;
@synthesize animating = _animating;
@synthesize key = _key;
@synthesize startHandler = _startHandler;
@synthesize completionHandler = _completionHandler;

#pragma mark - Initialization

+ (id)animation
{
    CABasicAnimation* animation = [super animation];
    animation.delegate = animation;
    return animation;
}

+ (id)animationWithKeyPath:(NSString*)path
{
    CABasicAnimation* animation = [super animationWithKeyPath:path];
    animation.delegate = animation;
    return animation;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone*)zone
{
    SDAnimation* newAnimation = [super copyWithZone:zone];
    newAnimation->_identifier = self.identifier;

    return newAnimation;
}

#pragma mark - SDAnimating

- (void)startAnimationOnLayer:(CALayer*)layer
{
    if (!self.isAnimating)
    {
        self.layer = layer;
        [layer addAnimation:self forKey:[self key]];
    }
}

- (void)stopAnimation
{
    [self.layer removeAnimationForKey:[self key]];
}

- (NSString*)key
{
    return [NSString stringWithFormat:@"%lu%ld", (unsigned long)[self hash], (long)self.identifier];
}

- (void)setLayer:(CALayer*)layer
{
    if (self.isAnimating)
    {
        SDLog(@"ERROR: Cannot mutate animation properties while animation is in progress.");
    }
    else
    {
        if (layer != _layer)
        {
            _layer = layer;
        }
    }
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CABasicAnimation*)animation
{
    self.animating = YES;

    [self sd_performBlock:^
    {
        if (self.startHandler)
        {
            self.startHandler();
        }
    }
    onMainThread:YES];
}

- (void)animationDidStop:(CAAnimation*)animation finished:(BOOL)flag
{
    self.animating = NO;
    
    [self sd_performBlock:^
    {
        if (self.completionHandler)
        {
            self.completionHandler(flag);
        }
    }
    onMainThread:YES];
}

@end
