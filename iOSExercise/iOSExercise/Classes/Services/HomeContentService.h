//
//  HomeContentService.h
//  iOSExercise
//
//  Created by Rahul C on 14/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Content.h"
#import "Constants.h"


@interface HomeContentService : NSObject

+ (void)callGetContentFeedData:(NSString *)urlString andCompletionBlock:(void (^)(ServiceStatus status, Content *content))completionBlock;

@end
