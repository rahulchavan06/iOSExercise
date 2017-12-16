//
//  HomeContentService.m
//  iOSExercise
//
//  Created by Rahul C on 14/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import "HomeContentService.h"

#import "ContentRows.h"

@implementation HomeContentService

+ (void)callGetContentFeedData:(NSString *)urlString andCompletionBlock:(void (^)(ServiceStatus status, Content *content))completionBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        //create Mutable request
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:BASE_URL]];
        //set request type
        request.HTTPMethod = GET;
        //set request content type
        [request setValue:kContentTypeValue forHTTPHeaderField:kContentTypeHeader];
        //call asynchronous request using NSURLConnection
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
        {
            if ([data length] > 0 && error == nil) {
                //Request executes successfully and fetched data. convert to NSString
                NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                //Parse NSString and retrieves the data
                NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                NSError *jsonError;
                NSDictionary *allKeys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
                
                //create model object and store parsed data into the model
                Content *content = [[Content alloc] init];
                content.title = [allKeys valueForKey:@"title"];
                content.rows = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in [allKeys valueForKey:@"rows"]) {
                    [content.rows addObject: [ContentRows contentRowsModelFromDictionary:dict]];
                }
                //Return Parsed data model and success status
                dispatch_async(dispatch_get_main_queue(), ^ {
                    completionBlock(ServiceSuccess, content);
                });
            } else if ([data length] == 0 && error == nil) {
                completionBlock(ServiceSuccessNoData, nil);
            } else if (error != nil && error.code == ERROR_CODE_TIMEOUT) {
                completionBlock(ServiceTimeout, nil);
            } else if (error != nil) {
                completionBlock(ServiceFail, nil);
                
            }
        }];
    });
}
                                                                         
@end
