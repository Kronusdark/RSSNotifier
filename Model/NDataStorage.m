//
//  NDataStorage.m
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import "NDataStorage.h"

@implementation NDataStorage

// Cached Feeds
+ (NSArray *)getFeeds {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:kNKeyFeeds];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)setFeeds:(NSArray *)feeds {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:feeds];
    [userDefaults setObject:data forKey:kNKeyFeeds];
    [userDefaults synchronize];
}


// Feed List
+ (NSArray *)getFeedList {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:kNKeyFeedList];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)setFeedList:(NSArray *)feedList {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:feedList];
    [userDefaults setObject:data forKey:kNKeyFeedList];
    [userDefaults synchronize];
}


// Settings
+ (NSDictionary *)getSettings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:kNKeySettings];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)setSettings:(NSDictionary *)settings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:settings];
    [userDefaults setObject:data forKey:kNKeySettings];
    [userDefaults synchronize];}

@end
