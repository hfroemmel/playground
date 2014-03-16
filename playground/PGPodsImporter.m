//
//  PGPodsImporter.m
//  playground
//
//  Created by Hendrik Frömmel on 14.03.14.
//  Copyright (c) 2014 Hendrik Frömmel. All rights reserved.
//

#import "PGPodsImporter.h"
#import "PGPodsWebService.h"
#import "Pod.h"


@interface PGPodsImporter ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) PGPodsWebService *webservice;
@property (nonatomic) int batchCount;
@end

@implementation PGPodsImporter


- (id)initWithContext:(NSManagedObjectContext *)context webservice:(PGPodsWebService *)webservice
{
    self = [super init];
    if (self) {
        self.context = context;
        self.webservice = webservice;
    }
    return self;
}

- (void)import
{
    self.batchCount = 0;
    [self.webservice fetchAllPods:^(NSArray *pods)
     {
         [self.context performBlock:^
          {
              for(NSDictionary *podSpec in pods) {
                  NSString *identifier = [podSpec[@"name"] stringByAppendingString:podSpec[@"version"]];
                  Pod *pod = [Pod findOrCreatePodWithIdentifier:identifier inContext:self.context];
                  [pod loadFromDictionary:podSpec];
              }
              self.batchCount++;
              if (self.batchCount % 10 == 0) {
                  NSError *error = nil;
                  [self.context save:&error];
                  if (error) {
                      NSLog(@"Error: %@", error.localizedDescription);
                  }
              }
          }];
     }];
}

@end