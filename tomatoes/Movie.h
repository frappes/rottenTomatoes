//
//  Movie.h
//  tomatoes
//
//  Created by Ross Danielson on 1/20/14.
//  Copyright (c) 2014 zynga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

+(Movie*)movieFactory:(NSDictionary*)json;

-(NSString*)castString;

@property (nonatomic)  NSString* title;
@property (nonatomic)  NSString* synopsis;
@property (nonatomic)  NSString* thumb;
@property (nonatomic)  NSString* big;
@property (nonatomic)  NSMutableArray* cast;

@end
