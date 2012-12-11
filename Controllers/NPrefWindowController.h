//
//  NPrefWindowController.h
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NPrefWindowController : NSWindowController <NSTableViewDataSource, NSTableViewDelegate, NSWindowDelegate>

// Actions
- (IBAction)buttonAdd:(id)sender;
- (IBAction)buttonRemove:(id)sender;
- (IBAction)showWindow:(id)sender;

// Outlets
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSButton *buttonRemove;
@property (weak) IBOutlet NSButton *buttonAdd;
@property (weak) IBOutlet NSTextField *textTitle;
@property (weak) IBOutlet NSTextField *textFeed;
@property (weak) IBOutlet NSTextField *textRefreshInterval;

@end
