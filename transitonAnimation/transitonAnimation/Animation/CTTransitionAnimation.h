//
//  CTTransitionAnimation.h
//  transitonAnimation
//
//  Created by ChaosTong on 2021/2/24.
//  Copyright © 2021年 ChaosTong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CTTransitionType) {
    CTTransitionTypePresent = 0,//管理present动画
    CTTransitionTypeDissmiss,
    CTTransitionTypePush,
    CTTransitionTypePop,
    CTTransitionTypePopLeft,
};

@interface CTTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

//动画转场类型
@property (nonatomic,assign) CTTransitionType transitionType;

@end
