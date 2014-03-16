//
//  Pod.m
//  playground
//
//  Created by Hendrik Frömmel on 14.03.14.
//  Copyright (c) 2014 Hendrik Frömmel. All rights reserved.
//

#import "Pod.h"

@implementation Pod

@dynamic authors;
@dynamic homepage;
@dynamic identifier;
@dynamic name;
@dynamic source;
@dynamic version;

- (void)loadFromDictionary:(NSDictionary *)dictionary
{
    self.name     = dictionary[@"name"];
    self.source   = dictionary[@"source"][@"git"];
    self.homepage = dictionary[@"homepage"];
    self.authors  = dictionary[@"authors"];
    self.version  = dictionary[@"version"];
}

+ (Pod *)findOrCreatePodWithIdentifier:(NSString *)identifier inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"error: %@", error.localizedDescription);
    }
    if (result.lastObject) {
        return result.lastObject;
    } else {
        Pod *pod = [self insertNewObjectIntoContext:context];
        pod.identifier = identifier;
        return pod;
    }
}

@end
