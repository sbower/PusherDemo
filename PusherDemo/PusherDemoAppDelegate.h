//
//  PusherDemoAppDelegate.h
//  PusherDemo
//
//  Created by Shawn Bower on 10/15/11.
//  Copyright 2011 iYouVo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTPusherDelegate.h"

@class PTPusher;

@interface PusherDemoAppDelegate : NSObject <UIApplicationDelegate, PTPusherDelegate> {
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) PTPusher *pusher;

@end
