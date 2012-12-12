//
//  NNewFeedItemProtocol.h
//  RSSNotifier
//
//  Created by Weston (Home) on 12/1/12.
//  Copyright (c) 2012 Weston Hanners. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWFeedItem.h"

@protocol NNewFeedItemProtocol <NSObject>

@required
- (void)newFeedItems:(MWFeedItem*)item title:(NSString*)title;

@end
