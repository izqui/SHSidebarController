//
//  AppDelegate.m
//  Example
//
//  Created by Jorge Izquierdo on 9/4/12.
//  Copyright (c) 2012 Jorge Izquierdo. All rights reserved.
//

#import "AppDelegate.h"
#import "SHSidebarController.h"
#import "BlueVC.h"
#import "RedVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSMutableArray *vcs = [NSMutableArray array];
    
    //6 views
    for (int i = 1; i <= 6; i++){
        
        //Check if index is pair
        if (i % 2 == 0){
            
            //Creating view
            BlueVC *blue = [[BlueVC alloc] init];
            
            //Navigation Controller is required
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:blue];
            
            //Dictionary of the view and title
            NSDictionary *view = [NSDictionary dictionaryWithObjectsAndKeys:nav, @"vc", [NSString stringWithFormat:@"Blue %i", i], @"title", nil];
        
            //And we finally add it to the array
            [vcs addObject:view];
        }
        
        else {
            
            RedVC *red = [[RedVC alloc] init];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:red];
            
            NSDictionary *view = [NSDictionary dictionaryWithObjectsAndKeys:nav, @"vc", [NSString stringWithFormat:@"Red %i", i], @"title", nil];
            [vcs addObject:view];

        }
    }
    
    //Create controller and set views
    SHSidebarController *sidebar = [[SHSidebarController alloc] initWithArrayOfVC:vcs];
    self.window.rootViewController = sidebar;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
