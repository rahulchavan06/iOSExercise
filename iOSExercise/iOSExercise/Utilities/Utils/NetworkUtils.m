//
//  NetworkUtils.h
//  iOSExercise
//
//  Created by Rahul C on 14/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import "NetworkUtils.h"

@implementation NetworkUtils

+ (BOOL)isNetworkAvailable {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        return NO;
    } else {
        NSLog(@"There IS internet connection");
        return YES;
    }
}



@end

