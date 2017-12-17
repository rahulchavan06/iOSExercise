//
//  Content.m
//  iOSExercise
//
//  Created by Rahul C on 14/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import "Content.h"

@implementation Content

- (NSDictionary *)jsonMapping {
    //create Json mapping dictionary with model key and Json key
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @"title",@"title",
            @"rows", @"rows",
            nil];
}

+ (Content *)contentModelFromDictionary:(NSDictionary *)dictionary {
    //Parse Json data dictionary and store into the model and return model
    Content *content = [[Content alloc] init];
    NSDictionary *mapping = [content jsonMapping];
    for (NSString *attribute in [mapping allKeys]) {
        //Retrieve model property
        NSString *classProperty = [mapping objectForKey:attribute];
        //Retrieve value for the respective propery
        NSString *attributeValue = [dictionary objectForKey:attribute];
       if (attributeValue!=nil&&([attributeValue isKindOfClass:[NSArray class]])) {
            //set value to respective model property
           NSArray *dictArray = [dictionary objectForKey:attribute];
           content.rows = [[NSMutableArray alloc] init];
           for (NSDictionary *dict in dictArray) {
               [content.rows addObject: [ContentRows contentRowsModelFromDictionary:dict]];
           }
       } else if (attributeValue!=nil&&!([attributeValue isKindOfClass:[NSNull class]])) {
           //set value to respective model property
           [content setValue:attributeValue forKeyPath:classProperty];
       }
    }
    return content;
}

@end
