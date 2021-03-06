//
//  JDScanLineAnimation.m
//  JDScanner
//
//  Created by WJD on 19/4/3.
//  Copyright © 2019 年 WJD. All rights reserved.
//

#import "JDScanLineAnimation.h"

@interface JDScanLineAnimation() {
    int num;
    BOOL down;
    NSTimer * timer;
    BOOL isAnimationing;
    UIImage *_animationImage;
}

@property (nonatomic,assign) CGRect animationRect;

@end

@implementation JDScanLineAnimation

- (instancetype)initWithAnimationImage:(UIImage *)animationImage {
    if (self = [super init]) {
        _animationImage = animationImage;
    }
    return self;
}

+ (instancetype)animationWithImage:(UIImage *)image {
    return [[JDScanLineAnimation alloc] initWithAnimationImage:image];
}

- (void)stepAnimation {
    if (!isAnimationing) {
        return;
    }
    
    CGFloat leftx = _animationRect.origin.x + 5;
    CGFloat width = _animationRect.size.width - 10;
    
    self.frame = CGRectMake(leftx, _animationRect.origin.y + 8, width, 8);
    self.alpha = 0.0;
    self.hidden = NO;
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
         weakSelf.alpha = 1.0;
    } completion:^(BOOL finished) {}];
    
    [UIView animateWithDuration:3 animations:^{
        CGFloat leftx = self->_animationRect.origin.x + 5;
        CGFloat width = self->_animationRect.size.width - 10;
        weakSelf.frame = CGRectMake(leftx, self->_animationRect.origin.y + self->_animationRect.size.height - 8, width, 4);
    } completion:^(BOOL finished) {
         self.hidden = YES;
         [weakSelf performSelector:@selector(stepAnimation) withObject:nil afterDelay:0.3];
     }];
}

- (void)startAnimatingWithRect:(CGRect)animationRect inView:(UIView *)parentView  {
    if (isAnimationing) {
        return;
    }
    
    isAnimationing = YES;
    self.animationRect = animationRect;
    down = YES;
    num =0;
    
    CGFloat centery = CGRectGetMinY(animationRect) + CGRectGetHeight(animationRect)/2;
    CGFloat leftx = animationRect.origin.x + 5;
    CGFloat width = animationRect.size.width - 10;
    
    self.frame = CGRectMake(leftx, centery+2*num, width, 2);
    self.image = _animationImage;
    
    [parentView addSubview:self];
    [self startAnimating_UIViewAnimation];
//    [self startAnimating_NSTimer];
}

- (void)startAnimating_UIViewAnimation {
     [self stepAnimation];
}

- (void)startAnimating_NSTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(scanLineAnimation) userInfo:nil repeats:YES];
}

- (void)scanLineAnimation {
    CGFloat centery = CGRectGetMinY(_animationRect) + CGRectGetHeight(_animationRect)/2;
    CGFloat leftx = _animationRect.origin.x + 5;
    CGFloat width = _animationRect.size.width - 10;
    
    if (down) {
        num++;
        self.frame = CGRectMake(leftx, centery+2*num, width, 2);
        if (centery+2*num > (CGRectGetMinY(_animationRect) + CGRectGetHeight(_animationRect) - 5)) {
            down = NO;
        }
    } else {
        num --;
        self.frame = CGRectMake(leftx, centery+2*num, width, 2);
        if (centery+2*num < (CGRectGetMinY(_animationRect) + 5 )) {
            down = YES;
        }
    }
}

- (void)dealloc {
    [self stopAnimating];
}

- (void)stopAnimating {
    if (isAnimationing) {
        isAnimationing = NO;
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        [self removeFromSuperview];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self];  
}

@end
