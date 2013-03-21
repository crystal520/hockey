//
//  AppDelegate.h
//  hokey_box2d
//
//  Created by admin on 10/5/12.
//  Copyright admin 2012. All rights reserved.
//
#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;
	
	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
