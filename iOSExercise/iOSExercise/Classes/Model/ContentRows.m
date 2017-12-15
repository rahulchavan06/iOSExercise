//
//  ContentRows.m
//  iOSExercise
//
//  Created by Rahul C on 14/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import "ContentRows.h"

@implementation ContentRows

- (NSDictionary *)jsonMapping {
    //create Json mapping dictionary with model key and Json key
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @"contentTitle",@"title",
            @"contentDescription",@"description",
            @"contentImagePath",@"imageHref",
            nil];
}

+ (ContentRows *)contentRowsModelFromDictionary:(NSDictionary *)dictionary {
    //Parse Json data dictionary and store into the model and return model
    ContentRows *contentRows = [[ContentRows alloc] init];
    NSDictionary *mapping = [contentRows jsonMapping];
    for (NSString *attribute in [mapping allKeys]) {
        //Retrieve model property
        NSString *classProperty = [mapping objectForKey:attribute];
        //Retrieve value for the respective propery
        NSString *attributeValue = [dictionary objectForKey:attribute];
        if (attributeValue!=nil&&!([attributeValue isKindOfClass:[NSNull class]])) {
            //set value to respective model property
            [contentRows setValue:attributeValue forKeyPath:classProperty];
        }
    }
    return contentRows;
}

@end
