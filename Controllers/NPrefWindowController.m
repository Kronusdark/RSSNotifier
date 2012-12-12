//
//  NPrefWindowController.m
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import "NPrefWindowController.h"
#import "NDataStorage.h"
#import "NRSSFeedListItem.h"

@interface NPrefWindowController ()

@end

@implementation NPrefWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];

    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)loadSettings {
    NSMutableDictionary *settings = [[NDataStorage getSettings] mutableCopy];
    self.textRefreshInterval.integerValue = [[settings valueForKey:kNKeyRefreshInterval] integerValue];
    if (![settings valueForKey:kNKeyRefreshInterval]) {
        self.textRefreshInterval.integerValue = 10;
        [settings setValue:@10 forKey:kNKeyRefreshInterval];
    }
    [NDataStorage setSettings:settings];
}

- (void)saveSettings {
    NSMutableDictionary *settings = [[NDataStorage getSettings] mutableCopy];
    
    // Settings
    
    [settings setValue:[NSNumber numberWithInteger:self.textRefreshInterval.integerValue] forKey:kNKeyRefreshInterval];
    
    [NDataStorage setSettings:settings];
}

- (IBAction)buttonAdd:(id)sender {
    
    NSURL *testURL = [NSURL URLWithString:self.textFeed.stringValue];
    BOOL bURLOK = NO;
    BOOL bTitleOK = NO;
    
    if (testURL && testURL.scheme && testURL.host) {
        self.textFeed.backgroundColor = [NSColor whiteColor];
        bURLOK = YES;
    } else {
        self.textFeed.backgroundColor = [NSColor redColor];
    }
    
    if (![self.textTitle.stringValue isEqualToString:@""]) {
        self.textTitle.backgroundColor = [NSColor whiteColor];
        bTitleOK = YES;
    } else {
        self.textTitle.backgroundColor = [NSColor redColor];
    }
    
    if (!bURLOK || !bTitleOK) {
        [self.textFeed resignFirstResponder];
        [self.textTitle resignFirstResponder];
        [self.window makeFirstResponder:nil];
        return;
    } else {
        // Save to UserPrefs
        NSMutableArray* currentFeeds = [NSMutableArray arrayWithArray:[NDataStorage getFeedList]];
        if (!currentFeeds) {
            currentFeeds = [[NSMutableArray alloc] init];
        }
        
        NRSSFeedListItem *feedToAdd = [NRSSFeedListItem new];
        [feedToAdd setTitle:_textTitle.stringValue];
        [feedToAdd setUrl:testURL];
        [currentFeeds addObject:feedToAdd];
        [NDataStorage setFeedList:[NSArray arrayWithArray:currentFeeds]];
        // Reload Table
        [self.tableView reloadData];
        
        // Clear text fields
        self.textTitle.stringValue = @"";
        self.textFeed.stringValue = @"";
        [self.window makeFirstResponder:nil];
    }

}

- (IBAction)buttonRemove:(id)sender {
    
    NSIndexSet *selectedRows = self.tableView.selectedRowIndexes;
    
    if (!selectedRows) return;
    
    // Load feed list into memory
    NSMutableArray* currentFeeds = [NSMutableArray arrayWithArray:[NDataStorage getFeedList]];
    
    // Remove selected feed.
    [self.tableView beginUpdates];
    [self.tableView removeRowsAtIndexes:selectedRows withAnimation:NSTableViewAnimationSlideRight];
    [currentFeeds removeObjectsAtIndexes:selectedRows];
    [self.tableView endUpdates];
    
    // Save our changes
    [NDataStorage setFeedList:[NSArray arrayWithArray:currentFeeds]];
    
    // Manage button state
    if (currentFeeds.count <= 0) [self.buttonRemove setEnabled:NO];

}

- (IBAction)showWindow:(id)sender {
    [self.window setIsVisible:YES];
    [self.window makeKeyWindow];
    [self.window orderFrontRegardless];
}

@end