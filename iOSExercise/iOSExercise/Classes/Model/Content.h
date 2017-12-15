//
//  Content.h
//  iOSExercise
//
//  Created by Rahul C on 14/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentRows.h"

@interface Content: NSObject

@property(strong, nonatomic)NSString *title;
@property(strong, nonatomic)NSMutableArray *rows;

- (NSDictionary *)jsonMapping;
+ (Content *)contentModelFromDictionary:(NSDictionary *)dictionary;

@end

