//
//  NRSSManager.h
//  RSSNotifier
//
//  Created by Weston (Work) on 11/30/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRSSManager : NSObject <RSSParserDelegate>

@property (weak) id<NNewFeedItemProtocol> delegate;

- (void)update;

@end
