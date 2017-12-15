//
//  ContentRows.h
//  iOSExercise
//
//  Created by Rahul C on 14/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentRows: NSObject

@property(strong, nonatomic)NSString *contentTitle;
@property(strong, nonatomic)NSString *contentDescription;
@property(strong, nonatomic)NSString *contentImagePath;

- (NSDictionary *)jsonMapping;
+ (ContentRows *)contentRowsModelFromDictionary:(NSDictionary *)dictionary;

@end
