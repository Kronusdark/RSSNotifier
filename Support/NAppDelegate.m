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
@property (strong) NSTimer *timer;

@end

@implementation NAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self enableStatusMenu];
    [self initTimer];
 
}

- (void)enableStatusMenu {
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    self.item = [bar statusItemWithLength:24];
    self.item.image = [NSImage imageNamed:@"icon"];
    [self.item setEnabled:YES];
    [self.item setHighlightMode:NO];
    [self.item setMenu:self.menu];
}

- (IBAction)showWindow:(id)sender {
    [self.window setIsVisible:YES];
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
    self.timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:(NSInteger)[[NSUserDefaults standardUserDefaults] valueForKey:@"refreshInterval"] target:self selector:@selector(fire:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)fire:(id)sender {
    NSLog(@"hit");
}

- (void)resetTimer:(NSTimer*)timer {
    
}
@end
