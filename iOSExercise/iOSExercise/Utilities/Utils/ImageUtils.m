//
//  ImageUtils.m
//  iOSExercise
//
//  Created by Rahul C on 19/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import "ImageUtils.h"
#import "Constants.h"

@implementation ImageUtils

//+ (NSData*)downloadUIImageInBackground:(NSString*)urlString {
//
//    //Call Async task to Load Feed Image
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            return data;
//        });
//    }];
//}

+ (void)downloadUIImageInBackground:(NSString*)urlString andCompletionBlock:(void (^)(NSData* data))completionBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //call asynchronous request using NSURLConnection
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if ([data length] > 0 && error == nil) {
                //Return Parsed data model and success status
                dispatch_async(dispatch_get_main_queue(), ^ {
                    completionBlock(data);
                });
            } else if ([data length] == 0 && error == nil) {
//                completionBlock(ServiceSuccessNoData, nil);
            } else if (error != nil && error.code == ERROR_CODE_TIMEOUT) {
//                completionBlock(ServiceTimeout, nil);
            } else if (error != nil) {
//                completionBlock(ServiceFail, nil);
            }
        }];
    });
}


@end
