//
//  NDataStorage.m
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import "NDataStorage.h"

@implementation NDataStorage

+ (NSArray *)getFeeds {
    NSArray *feeds = [[NSUserDefaults standardUserDefaults] arrayForKey:@"feeds"];
    return feeds;
}

+ (void)setFeeds:(NSArray *)feeds {
    [[NSUserDefaults standardUserDefaults] setObject:feeds forKey:@"feeds"];
}

+ (NSDictionary *)getSettings {
    NSDictionary *settings = [[NSUserDefaults standardUserDefaults] arrayForKey:@"settings"];
    return settings;
}

+ (void)setSettings:(NSDictionary *)settings {
    [[NSUserDefaults standardUserDefaults] setObject:settings forKey:@"feeds"];
}

@end
