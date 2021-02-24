//
//  CTTransitionInteractive.h
//  transitonAnimation
//
//  Created by ChaosTong on 2021/2/24.
//  Copyright © 2021年 ChaosTong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CTInteractiveType) {
    CTInteractiveTypePresent = 0,//管理present交互
    CTInteractiveTypeDissmiss,
    CTInteractiveTypePush,
    CTInteractiveTypePop,
};

@interface CTTransitionInteractive : UIPercentDrivenInteractiveTransition

@property (nonatomic, strong) UIViewController *viewController;
/**
 区分是手势交互转场还是直接pop/push、present/dissmiss转场
 */
@property (nonatomic, assign) BOOL isInteractive;
@property (nonatomic, assign) CTInteractiveType interactiveType;

//给控制器的View添加相应的手势
- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end
