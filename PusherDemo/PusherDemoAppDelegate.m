//
//  PusherDemoAppDelegate.m
//  PusherDemo
//
//  Created by Shawn Bower on 10/15/11.
//  Copyright 2011 iYouVo. All rights reserved.
//

#import "PTPusher.h"
#import "PTPusherEvent.h"
#import "PusherDemoAppDelegate.h"
#import "Constants.h" 

@implementation PusherDemoAppDelegate

NSString * const PUSHER_APP_ID = @"9686";
NSString * const PUSHER_API_KEY = @"630dc45aa9412e9fbda5";
NSString * const PUSHER_API_SECRET = @"d1ab1f17643a08bb3778";
NSString * const CHANNEL_AUTH_USERNAME = @"";
NSString * const CHANNEL_AUTH_PASSWORD = @"";

@synthesize window = _window;
@synthesize pusher = _pusher;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // establish a new pusher instance
    self.pusher = [PTPusher pusherWithKey:PUSHER_API_KEY delegate:self];

    
    // we want the connection to automatically reconnect if it dies
    self.pusher.reconnectAutomatically = YES;
    
    PTPusherChannel *currentChannel = [self.pusher subscribeToChannelNamed:@"test_channel"];
    [currentChannel bindToEventNamed:@"my_event" target:self action:@selector(handleEvent:)];
    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)handleEvent:(PTPusherEvent *)event;
{
    // lets just log the event name and data
    NSLog(@"Received event %@, data: %@", event.name, event.data);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

#pragma mark - Event notifications

- (void)handlePusherEvent:(NSNotification *)note
{
    PTPusherEvent *event = [note.userInfo objectForKey:PTPusherEventUserInfoKey];
    NSLog(@"[pusher] Received event %@", event);
}

#pragma mark - PTPusherDelegate methods

- (void)pusher:(PTPusher *)pusher connectionDidConnect:(PTPusherConnection *)connection
{
    NSLog(@"[pusher-%@] Connected to Pusher (socket id: %@)", pusher.connection.socketID, connection.socketID);
}

- (void)pusher:(PTPusher *)pusher connectionDidDisconnect:(PTPusherConnection *)connection
{
    NSLog(@"[pusher-%@] Disconnected from Pusher", pusher.connection.socketID);
}

- (void)pusher:(PTPusher *)pusher connection:(PTPusherConnection *)connection failedWithError:(NSError *)error
{
    NSLog(@"[pusher-%@] Failed to connect to pusher, error: %@", pusher.connection.socketID, error);
}

- (void)pusher:(PTPusher *)pusher connectionWillReconnect:(PTPusherConnection *)connection afterDelay:(NSTimeInterval)delay
{
    NSLog(@"[pusher-%@] Reconnecting after %d seconds...", pusher.connection.socketID, (int)delay);
}

- (void)pusher:(PTPusher *)pusher didFailToSubscribeToChannel:(PTPusherChannel *)channel withError:(NSError *)error
{
    NSLog(@"[pusher-%@] Authorization failed for channel %@", pusher.connection.socketID, channel);
}

/* The sample app uses HTTP basic authentication.
 
 This demonstrates how we can intercept the authorization request to configure it for our app's
 authentication/authorisation needs.
 */
- (void)pusher:(PTPusher *)pusher willAuthorizeChannelWithRequest:(NSMutableURLRequest *)request
{
    //[request setHTTPBasicAuthUsername:CHANNEL_AUTH_USERNAME password:CHANNEL_AUTH_PASSWORD];
}

@end
