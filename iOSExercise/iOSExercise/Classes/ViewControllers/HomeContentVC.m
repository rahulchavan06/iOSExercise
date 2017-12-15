//
//  HomeContentVC.m
//  iOSExercise
//
//  Created by Rahul C on 14/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import "HomeContentVC.h"
#import "HomeContentService.h"
#import "Constants.h"
#import "NetworkUtils.h"

@interface HomeContentVC ()

@property (nonatomic, strong) Content *contentData;

@end

@implementation HomeContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Call fetch content Api
    [self callGetHomeContentApi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Web service call

- (void)callGetHomeContentApi {
    
    //Call GetContent Feeds data web service through completion handler
    if ([NetworkUtils isNetworkAvailable]) {
        [HomeContentService callGetContentFeedData:@"" andCompletionBlock:^(BOOL status, Content *content) {
            if(status) {
                self.contentData = content;
                NSLog(@"success");
            } else {
                NSLog(@"failed");
            }
        }];
    } else {
        //No internet connectivity alert
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Connectivity!"
                                                                 message:@"Please check your internet connection and try again."
                                                                delegate:self
                                                       cancelButtonTitle:nil
                                                       otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

@end
