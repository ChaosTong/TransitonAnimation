//
//  CTTransitionInteractive.m
//  transitonAnimation
//
//  Created by ChaosTong on 2021/2/24.
//  Copyright © 2021年 ChaosTong. All rights reserved.
//

#import "CTTransitionInteractive.h"

@implementation CTTransitionInteractive

//给控制器的View添加相应的手势
- (void)addPanGestureForViewController:(UIViewController *)viewController {
    UIScreenEdgePanGestureRecognizer *left = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    left.edges = UIRectEdgeLeft;
    [viewController.view addGestureRecognizer:left];
    UIScreenEdgePanGestureRecognizer *right = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    right.edges = UIRectEdgeRight;
    [viewController.view addGestureRecognizer:right];
    
    self.viewController = viewController;
}

//关键的手势过渡的过程
- (void)handleGesture:(UIScreenEdgePanGestureRecognizer *)panGesture {
    switch (_interactiveType) {
        case CTInteractiveTypePresent:
            [self doInteractiveTypePresent:panGesture];
            break;
        case CTInteractiveTypeDissmiss:
            [self doInteractiveTypeDissmiss:panGesture];
            break;
        case CTInteractiveTypePush:
            [self doInteractiveTypePush:panGesture];
            break;
        case CTInteractiveTypePop:
            [self doInteractiveTypePop:panGesture];
            break;
        default:
            break;
    }
}

- (void)doInteractiveTypePresent:(UIPanGestureRecognizer *)panGesture { }

- (void)doInteractiveTypeDissmiss:(UIPanGestureRecognizer *)panGesture { }

- (void)doInteractiveTypePush:(UIPanGestureRecognizer *)panGesture { }

- (void)doInteractiveTypePop:(UIScreenEdgePanGestureRecognizer *)panGesture {
    CGPoint  translation = [panGesture translationInView:panGesture.view];
    CGFloat percentComplete = 0.0;
    BOOL _isLeft = panGesture.edges == UIRectEdgeLeft;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Left" object:@{@"Left":@(_isLeft)}];
    
    //左右滑动的百分比
    percentComplete = translation.x / (_viewController.view.frame.size.width);
    NSLog(@"%f",percentComplete);
    percentComplete = fabs(percentComplete);
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            _isInteractive = YES;
            [_viewController.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged: {
            //手势过程中，通过updateInteractiveTransition设置转场过程动画进行的百分比，然后系统会根据百分比自动布局动画控件，不用我们控制了
            [self updateInteractiveTransition:percentComplete];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            _isInteractive = NO;
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作，转场失败
            if ((!_isLeft && percentComplete > 0.2) || percentComplete > 0.5) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
    
}

@end
