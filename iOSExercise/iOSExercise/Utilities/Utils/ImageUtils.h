//
//  ImageUtils.h
//  iOSExercise
//
//  Created by Rahul C on 19/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtils : NSObject

+ (void)downloadUIImageInBackground:(NSString*)urlString andCompletionBlock:(void (^)(NSData* data))completionBlock;

@end
