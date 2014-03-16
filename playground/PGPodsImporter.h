//
//  PGPodsImporter.h
//  playground
//
//  Created by Hendrik Frömmel on 14.03.14.
//  Copyright (c) 2014 Hendrik Frömmel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PGPodsWebService;

@interface PGPodsImporter : NSObject

- (id)initWithContext:(NSManagedObjectContext *)context
           webservice:(PGPodsWebService *)webservice;
- (void)import;

@end
