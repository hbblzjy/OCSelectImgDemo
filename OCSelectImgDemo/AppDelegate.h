//
//  AppDelegate.h
//  OCSelectImgDemo
//
//  Created by healthmanage on 17/1/13.
//  Copyright © 2017年 healthmanager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

