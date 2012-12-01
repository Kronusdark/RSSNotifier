//
//  NAppDelegate.m
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import "NAppDelegate.h"

@interface NAppDelegate () {
    NSStatusItem *item;
    IBOutlet NSMenu *statusMenu;
}

@end

@implementation NAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self enableStatusMenu];
 
}

- (void)enableStatusMenu {
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    item = [bar statusItemWithLength:24];
    item.image = [NSImage imageNamed:@"icon"];
    [item setEnabled:YES];
    [item setHighlightMode:YES];
    [item setMenu:statusMenu];
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
