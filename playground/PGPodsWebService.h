//
//  PGPodsWebService.h
//  playground
//
//  Created by Hendrik Frömmel on 14.03.14.
//  Copyright (c) 2014 Hendrik Frömmel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGPodsWebService : NSObject

- (void)fetchAllPods:(void (^)(NSArray *pods))callback;

@end
