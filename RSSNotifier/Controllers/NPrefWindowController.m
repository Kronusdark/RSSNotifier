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
    return [NDataStorage.feeds count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return [[NDataStorage.feeds objectAtIndex:row] valueForKey:tableColumn.identifier];
}


- (IBAction)stepperValueChanged:(id)sender {
    
}

- (IBAction)buttonAdd:(id)sender {
}

- (IBAction)buttonRemove:(id)sender {
}
@end
