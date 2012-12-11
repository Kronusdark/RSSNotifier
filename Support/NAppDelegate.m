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

@interface NAppDelegate ()

@property (strong) NSStatusItem *item;
@property (weak) IBOutlet NSMenu *menu;
@property (strong) IBOutlet NRSSManager *rssManager;
@property (weak) IBOutlet NSObjectController *settingsController;
@property (strong) NSTimer *timer;

@end

@implementation NAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self loadInitialValues];
    [self enableStatusMenu];
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
- (IBAction)refreshFeeds:(id)sender {
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification {
    
}

- (void)newFeedItem:(RSSFeed *)feed {
    NSLog(@"%@", [[feed.articles objectAtIndex:0] title]);
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
    NSLog(@"hit");
}

- (IBAction)updateSetting:(id)sender {
    [self initTimer];
}

@end
