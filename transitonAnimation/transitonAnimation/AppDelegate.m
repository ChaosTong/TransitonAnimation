//
//  AppDelegate.m
//  transitonAnimation
//
//  Created by chaostong on 2021/2/24.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "C_Navigation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController *vc = [[ViewController alloc] init];
    C_Navigation *nav = [[C_Navigation alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
