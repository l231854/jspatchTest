//
//  AppDelegate.m
//  jspatchTest
//
//  Created by 雷王 on 2018/9/10.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "AppDelegate.h"
#import "JPEngine.h"
#import "JPViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self sendRequestOfJs];

//    [JPEngine startEngine];
//    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
//    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
//    [JPEngine evaluateScript:script];
    
   
    return YES;
}

#pragma mark --请求js文件
-(void)updateUI
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingString:@"/JS"];
//    //  创建目录
//    [fileManger createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    //  创建文件
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"demo2.js"];
    [JPEngine startEngine];
    NSString *script = [NSString stringWithContentsOfFile:testPath encoding:NSUTF8StringEncoding error:nil];
    [JPEngine evaluateScript:script];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    JPViewController *rootViewController = [[JPViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];

}
-(void)sendRequestOfJs
{
    // 在子线程中发送下载文件请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 创建下载路径
        NSURL *url = [NSURL URLWithString:@"http://10.1.138.92/demo2"];
        
        // NSData的dataWithContentsOfURL:方法下载
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSLog(@"%@",data);
        NSData *doubi = data;
        //  二进制流写入文件
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSFileManager *fileManger = [NSFileManager defaultManager];
        NSString *testDirectory = [documentsDirectory stringByAppendingString:@"/JS"];
        //  创建目录
        [fileManger createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        //  创建文件
        NSString *testPath = [testDirectory stringByAppendingPathComponent:@"demo2.js"];
        //  写入文件
        [fileManger createFileAtPath:testPath contents:doubi attributes:nil];
       
        [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];

    });
    
////    NSURL *url = [NSURL URLWithString:@"http://10.1.138.92/demo2"];
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//
////http://10.1.138.92/demo2
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod=@"POST";
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (error) {
//                //失败
//            }else{
//                NSError *error;
//                NSMutableDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//                if (error) {
//                    //失败
//                }
//                else{
//
//                }
//            }
//        });
//    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
