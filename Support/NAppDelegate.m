//
//  NAppDelegate.m
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import "NAppDelegate.h"
#import "NRSSManager.h"
#import "NDataStorage.h"
#import "NSString+HTML.h"

@interface NAppDelegate ()

@property (strong) NSStatusItem *item;
@property (weak) IBOutlet NSMenu *menu;
@property (strong) IBOutlet NRSSManager *rssManager;
@property (weak) IBOutlet NSObjectController *settingsController;
@property (strong) NSTimer *timer;
@property bool updateSetting;

@end

@implementation NAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Setup

    // Mountain Lion Notification Center
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    if (center) {
        [center setDelegate:self];
    } else {
        // Growl
        [GrowlApplicationBridge setGrowlDelegate:self];
    }

    // Other Setup
    self.updateSetting = NO;
    [self loadInitialValues];
    [self enableStatusMenu];
    [self.rssManager setDelegate:self];
    [self initTimer];

}

- (void)loadInitialValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *initialValues = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"defaults" ofType:@"plist"]];
    [defaults registerDefaults:initialValues];
    
}

- (void)enableStatusMenu {
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    self.item = [bar statusItemWithLength:24];
    self.item.image = [NSImage imageNamed:@"icon"];
    [self.item setEnabled:YES];
    [self.item setHighlightMode:NO];
    [self.item setMenu:self.menu];
}


- (IBAction)quitApplication:(id)sender {
    [[NSApplication sharedApplication] terminate:self];
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification {
    NSURL *url = [NSURL URLWithString:[notification.userInfo valueForKey:kNKeyLink]];
    [[NSWorkspace sharedWorkspace] openURL:url];
    [center removeDeliveredNotification:notification];
}


- (void)growlNotificationWasClicked:(id)clickContext {
    NSURL *url = [NSURL URLWithString:[clickContext valueForKey:kNKeyLink]];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

- (void)newFeedItems:(MWFeedItem *)item title:(NSString *)title {
        NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];

        if (center) {
            // Notification Center
            NSUserNotification *note = [[NSUserNotification alloc] init];
            [note setTitle:[NSString stringWithFormat:@"%@ - %@",title, [item.title stringByConvertingHTMLToPlainText]]];
            NSLog(@"%@", [item.title stringByConvertingHTMLToPlainText]);
            [note setInformativeText:[item.summary stringByConvertingHTMLToPlainText]];
            [note setUserInfo:@{kNKeyLink : item.link}];
            [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:note];
        } else {
            // Growl
            [GrowlApplicationBridge notifyWithTitle:[NSString stringWithFormat:@"%@ - %@", title, [item.title stringByConvertingHTMLToPlainText]]
                                        description:[item.summary stringByConvertingHTMLToPlainText]
                                   notificationName:kNKeyGrowlNotificationName
                                           iconData:nil
                                           priority:0
                                           isSticky:NO
                                       clickContext:@{kNKeyLink : item.link}];
        }
}

- (void)initTimer {
    if (self.timer) {
        [self.timer invalidate];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSTimeInterval time = [[defaults valueForKeyPath:kNKeyRefreshInterval] integerValue];
    self.timer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(fire:) userInfo:nil repeats:YES];
    [self.timer setFireDate:[NSDate date]];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)fire:(id)sender {
    if (_updateSetting) {
        _updateSetting = NO;
        [self initTimer];
    } else {
        [_rssManager update];
    }

}

- (IBAction)updateSetting:(id)sender {
    self.updateSetting = YES;
}

@end
