//
//  WSLAnimationFour.m
//  transitonAnimation
//
//  Created by ChaosTong on 2021/2/24.
//  Copyright © 2021年 ChaosTong. All rights reserved.
//

#import "VC_Animation.h"
#import "PrefixHeader.pch"
#import "CTTransitionAnimation.h"
#import "CTTransitionInteractive.h"

@interface VC_Animation () {
    BOOL _isLeft;
}

@property (nonatomic, strong) UIImageView *imageView;
//动画过渡转场
@property (nonatomic, strong) CTTransitionAnimation *transitionAnimation;
//手势过渡转场
@property (nonatomic, strong) CTTransitionInteractive *transitionInteractive;

@end

@implementation VC_Animation

- (instancetype)init {
    if (self == [super init]) {
        self.transitionAnimation.transitionType = CTTransitionTypePush;
        self.transitionInteractive.interactiveType = CTInteractiveTypePop;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isLeft = nil;
    self.navigationItem.title = @"左右侧滑返回转场";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(isLeftGes:)
                                                 name:@"Left"
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    self.navigationController.delegate = nil;
}

- (void)isLeftGes:(NSNotification *)notification {
    NSDictionary *dic = notification.object;
    _isLeft = [dic[@"Left"] boolValue];
}

#pragma mark -- UINavigationControllerDelegate
//返回处理push/pop动画过渡的对象
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        self.transitionAnimation.transitionType = CTTransitionTypePush;
    } else if (operation == UINavigationControllerOperationPop) {
        if (_isLeft) {
            self.transitionAnimation.transitionType = CTTransitionTypePopLeft;
        } else {
            self.transitionAnimation.transitionType = CTTransitionTypePop;
        }
    }
    return self.transitionAnimation;
}

//返回处理push/pop手势过渡的对象 这个代理方法依赖于上方的方法 ，这个代理实际上是根据交互百分比来控制上方的动画过程百分比
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    //手势开始的时候才需要传入手势过渡代理，如果直接pop或push，应该返回nil，否者无法正常完成pop/push动作
    if (self.transitionAnimation.transitionType == CTTransitionTypePop || self.transitionAnimation.transitionType == CTTransitionTypePopLeft) {
        return self.transitionInteractive.isInteractive == YES ? self.transitionInteractive : nil;
    }
    return nil;
}

#pragma mark -- Getter
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
        _imageView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        _imageView.image = [UIImage imageNamed:@"Chaos"];
    }
    return _imageView;
}

- (CTTransitionAnimation *)transitionAnimation {
    if (_transitionAnimation == nil) {
        _transitionAnimation = [[CTTransitionAnimation alloc] init];
    }
    return _transitionAnimation;
}

- (CTTransitionInteractive *)transitionInteractive {
    if (_transitionInteractive == nil) {
        _transitionInteractive = [[CTTransitionInteractive alloc] init];
        [_transitionInteractive addPanGestureForViewController:self];
    }
    return _transitionInteractive;
}

@end
