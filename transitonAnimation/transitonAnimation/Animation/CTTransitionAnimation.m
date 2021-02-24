//
//  CTTransitionAnimation.m
//  transitonAnimation
//
//  Created by ChaosTong on 2021/2/24.
//  Copyright © 2021年 ChaosTong. All rights reserved.
//

#import "CTTransitionAnimation.h"

@implementation CTTransitionAnimation

//返回动画事件
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    switch (_transitionType) {
        case CTTransitionTypePresent:
            return 0.8;
            break;
        case CTTransitionTypeDissmiss:
            return 0.8;
            break;
        case CTTransitionTypePush:
            return 0.3;
            break;
        case CTTransitionTypePop:
            return 0.3;
            break;
        case CTTransitionTypePopLeft:
            return 0.3;
            break;
    }
    return 0.8;
}

//所有的过渡动画事务都在这个方法里面完成
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    switch (_transitionType) {
        case CTTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case CTTransitionTypeDissmiss:
            [self dismissAnimation:transitionContext];
            break;
        case CTTransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
        case CTTransitionTypePop:
            [self popAnimation:transitionContext];
            break;
        case CTTransitionTypePopLeft:
            [self popLeftAnimation:transitionContext];
            break;
    }
}

#pragma mark -- transitionType
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}

- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
//    取出转场前后视图控制器上的视图view
        UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        UIView *containerView = [transitionContext containerView];
        
        //左侧动画视图
        UIView *leftFromView = [fromView snapshotViewAfterScreenUpdates:NO];
        UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fromView.frame.size.width, fromView.frame.size.height)];
        leftView.clipsToBounds = YES;
        [leftView addSubview:leftFromView];
        
        [containerView addSubview:toView];
        [containerView addSubview:leftView];
        
        fromView.hidden = YES;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
                            options:UIViewAnimationOptionTransitionFlipFromRight
                         animations:^{
            leftView.frame = CGRectMake(-fromView.frame.size.width, 0, fromView.frame.size.width, fromView.frame.size.height);
        }
                         completion:^(BOOL finished) {
            fromView.hidden = NO;
            [leftView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
}

- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    //取出转场前后视图控制器上的视图view
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    //右侧动画视图
    UIView *rightFromView = [fromView snapshotViewAfterScreenUpdates:NO];
    rightFromView.frame = CGRectMake(0, 0, fromView.frame.size.width, fromView.frame.size.height);
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fromView.frame.size.width, fromView.frame.size.height)];
    rightView.clipsToBounds = YES;
    [rightView addSubview:rightFromView];
    
    [containerView addSubview:toView];
    [containerView addSubview:rightView];
    
    fromView.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{
                         rightView.frame = CGRectMake(-fromView.frame.size.width, 0, fromView.frame.size.width, fromView.frame.size.height);
                     }
                     completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            //手势取消
            fromView.hidden = NO;
        } else {
            //手势完成
            [containerView addSubview:toView];
        }
        [rightView removeFromSuperview];
        toView.hidden = NO;
    }];
}

- (void)popLeftAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    //取出转场前后视图控制器上的视图view
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    //右侧动画视图
    UIView *rightFromView = [fromView snapshotViewAfterScreenUpdates:NO];
    rightFromView.frame = CGRectMake(0, 0, fromView.frame.size.width, fromView.frame.size.height);
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fromView.frame.size.width, fromView.frame.size.height)];
    rightView.clipsToBounds = YES;
    [rightView addSubview:rightFromView];
    
    [containerView addSubview:toView];
    [containerView addSubview:rightView];
    
    fromView.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{
                         rightView.frame = CGRectMake(fromView.frame.size.width, 0, fromView.frame.size.width, fromView.frame.size.height);
                     }
                     completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            //手势取消
            fromView.hidden = NO;
        } else {
            //手势完成
            [containerView addSubview:toView];
        }
        [rightView removeFromSuperview];
        toView.hidden = NO;
    }];
}

@end
