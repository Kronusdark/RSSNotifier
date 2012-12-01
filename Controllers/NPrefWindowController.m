//
//  NPrefWindowController.m
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import "NPrefWindowController.h"
#import "NDataStorage.h"

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

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSArray *feeds = [NDataStorage getFeeds];

    if (feeds.count == 0) {
        [self.buttonRemove setEnabled:NO];
    } else {
        [self.buttonRemove setEnabled:YES];
    }
    return feeds.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return [[[NDataStorage getFeeds] objectAtIndex:row] valueForKey:tableColumn.identifier];
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
        NSMutableArray* currentFeeds = [NSMutableArray arrayWithArray:[NDataStorage getFeeds]];
        if (!currentFeeds) {
            currentFeeds = [[NSMutableArray alloc] init];
        }
        
        RSSFeed *feedToAdd = [RSSFeed new];
        [feedToAdd setTitle:_textTitle.stringValue];
        [feedToAdd setUrl:_textFeed.stringValue];
        [currentFeeds addObject:feedToAdd];
        [NDataStorage setFeeds:[NSArray arrayWithArray:currentFeeds]];
        // Reload Table
        [self.tableView reloadData];
        
        // Clear text fields
        self.textTitle.stringValue = @"";
        self.textFeed.stringValue = @"";
        [self.window makeFirstResponder:nil];
    }

}

- (IBAction)buttonRemove:(id)sender {
    
    NSInteger selectedRow = self.tableView.selectedRow;
    
    if (selectedRow == -1) return;
    NSIndexSet *indicies = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(selectedRow, 1)];
    
    // Load feed list into memory
    NSMutableArray* currentFeeds = [NSMutableArray arrayWithArray:[NDataStorage getFeeds]];
    
    // Remove selected feed.
    [self.tableView beginUpdates];
    [currentFeeds removeObjectAtIndex:self.tableView.selectedRow];
    [self.tableView endUpdates];
    
    // Save our changes
    [NDataStorage setFeeds:[NSArray arrayWithArray:currentFeeds]];
    
    // Manage tableview selection
    if (currentFeeds.count > selectedRow) {
        [self.tableView selectRowIndexes:indicies byExtendingSelection:NO];
    } else if (currentFeeds.count <= selectedRow) {
        [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(selectedRow - 1, 1)] byExtendingSelection:NO];
    }
    
    // Manage button state
    if (currentFeeds.count <= 0) [self.buttonRemove setEnabled:NO];

}

@end