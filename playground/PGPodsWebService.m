//
//  PGPodsWebService.m
//  playground
//
//  Created by Hendrik Frömmel on 14.03.14.
//  Copyright (c) 2014 Hendrik Frömmel. All rights reserved.
//

#import "PGPodsWebService.h"
#import "PGConstants.h"

@implementation PGPodsWebService

- (void)fetchAllPods:(void (^)(NSArray *pods))callback
{
    [self fetchAllPods:callback page:0];
}

- (void)fetchAllPods:(void (^)(NSArray *pods))callback page:(NSUInteger)page
{
    NSString *urlString = [NSString stringWithFormat:@"%@/specs?page=%d", POD_SERVER_URL, page];
    NSURL *url = [NSURL URLWithString:urlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:
      ^(NSData *data, NSURLResponse *response, NSError *error) {
          id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
          if ([result isKindOfClass:[NSDictionary class]]) {
              NSArray *pods = result[@"result"];
              callback(pods);
              NSNumber* numberOfPages = result[@"number_of_pages"];
              NSUInteger nextPage = page + 1;
              if (nextPage < numberOfPages.unsignedIntegerValue) {
                  [self fetchAllPods:callback page:nextPage];
              }
          }
      }] resume];
}

@end
