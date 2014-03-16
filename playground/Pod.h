//
//  Pod.h
//  playground
//
//  Created by Hendrik Frömmel on 14.03.14.
//  Copyright (c) 2014 Hendrik Frömmel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Pod : NSManagedObject

@property (nonatomic, retain) id authors;
@property (nonatomic, retain) NSString * homepage;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * version;

@end
