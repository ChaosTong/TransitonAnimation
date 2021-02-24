//
//  C_Navigation.m
//  transitonAnimation
//
//  Created by chaostong on 2021/2/24.
//

#import "C_Navigation.h"

@interface C_Navigation () <UINavigationBarDelegate>

@end

@implementation C_Navigation

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self == [super initWithRootViewController:rootViewController]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor clearColor];
}


- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Left" object:@{@"Left":@1}];
    return true;
}

@end
