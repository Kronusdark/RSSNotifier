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
#import "NSString_stripHtml.h"

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
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    self.updateSetting = NO;
    [center setDelegate:self];
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

- (void)newFeedItems:(NSArray *)items {
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    for (RSSEntry *f in items) {
        NSUserNotification *note = [[NSUserNotification alloc] init];
        [note setTitle:[NSString stringWithFormat:@"%@ - %@",f.feedTitle, [f.title stripHtml]]];
        [note setInformativeText:[f.summary stripHtml]];
        [note setUserInfo:@{kNKeyLink : f.url}];
        [center deliverNotification:note];
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
