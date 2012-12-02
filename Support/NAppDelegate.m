//
//  NAppDelegate.m
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import "NAppDelegate.h"
#import "NRSSManager.h"

@interface NAppDelegate ()

@property (strong) NSStatusItem *item;
@property (weak) IBOutlet NSMenu *menu;
@property (strong) IBOutlet NRSSManager *rssManager;

@end

@implementation NAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self enableStatusMenu];
 
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

@end
