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
    return feeds.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return [[[NDataStorage getFeeds] objectAtIndex:row] valueForKey:tableColumn.identifier];
}


- (void)loadSettings {
    NSMutableDictionary *settings = [[NDataStorage getSettings] mutableCopy];
    self.textRefreshInterval.integerValue = [[settings valueForKey:@"refreshInterval"] integerValue];
    if (![settings valueForKey:@"refreshInterval"]) {
        self.textRefreshInterval.integerValue = 10;
        [settings setValue:@10 forKey:@"refreshInterval"];
    }
    [NDataStorage setSettings:settings];
}

- (void)saveSettings {
    NSMutableDictionary *settings = [[NDataStorage getSettings] mutableCopy];
    
    // Settings
    
    [settings setValue:[NSNumber numberWithInteger:self.textRefreshInterval.integerValue] forKey:@"refreshInterval"];
    
    [NDataStorage setSettings:settings];
}

- (IBAction)buttonAdd:(id)sender {
    NSMutableArray* currentFeeds = [NSMutableArray arrayWithArray:[NDataStorage getFeeds]];
    if (!currentFeeds) {
        currentFeeds = [[NSMutableArray alloc] init];
    }
    RSSFeed *feedToAdd = [RSSFeed new];
    [feedToAdd setTitle:_textTitle.stringValue];
    [feedToAdd setUrl:_textFeed.stringValue];
    [currentFeeds addObject:feedToAdd];
    [NDataStorage setFeeds:[NSArray arrayWithArray:currentFeeds]];
}

- (IBAction)buttonRemove:(id)sender {
    NSMutableArray* currentFeeds = [NSMutableArray arrayWithArray:[NDataStorage getFeeds]];
    [_tableView beginUpdates];
    [currentFeeds removeObjectAtIndex:_tableView.selectedRow];
    [_tableView endUpdates];
    [NDataStorage setFeeds:[NSArray arrayWithArray:currentFeeds]];
}
@end
