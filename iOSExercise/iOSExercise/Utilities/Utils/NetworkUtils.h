//
//  NetworkUtils.h
//  iOSExercise
//
//  Created by Rahul C on 14/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NetworkUtils : NSObject

+ (BOOL)isNetworkAvailable;

@end
