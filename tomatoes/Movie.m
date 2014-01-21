//
//  Movie.m
//  tomatoes
//
//  Created by Ross Danielson on 1/20/14.
//  Copyright (c) 2014 zynga. All rights reserved.
//

#import "Movie.h"

@interface Movie ()



@end

@implementation Movie


+(Movie*) movieFactory:(NSDictionary *)json {
    Movie* toReturn = [[Movie alloc] init];
    
    //NSLog(@"%@",json);
    
    toReturn.title = [json objectForKey:@"title"];
    toReturn.synopsis = [json objectForKey:@"synopsis"];
    toReturn.thumb = json[@"posters"][@"thumbnail"];
    toReturn.big = json[@"posters"][@"original"];
    
    NSArray* array = json[@"abridged_cast"];
    
    toReturn.cast = [[NSMutableArray alloc] init];
    
    for(NSDictionary* actor in array) {
        [toReturn.cast addObject:actor[@"name"]];
    }
    
    NSLog(@"%@",toReturn.cast);
    
    return toReturn;
}

-(NSString*)castString {
    return [self.cast componentsJoinedByString:@", "];
}

@end
