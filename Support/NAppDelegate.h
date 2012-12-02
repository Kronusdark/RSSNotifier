//
//  NAppDelegate.h
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NAppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate, NNewFeedItemProtocol>

@property (assign) IBOutlet NSWindow *window;

- (IBAction)updateSetting:(id)sender;

@end
