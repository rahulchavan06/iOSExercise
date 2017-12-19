//
//  iOSExerciseTests.m
//  iOSExerciseTests
//
//  Created by Rahul C on 14/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HomeContentVC.h"

@interface iOSExerciseTests : XCTestCase

@property (nonatomic) HomeContentVC *homeContentVC;

@end

@implementation iOSExerciseTests

- (void)setUp {
    [super setUp];
    
    self.homeContentVC = [[HomeContentVC alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetFeedAPIRefreshPerformance {
    [self measureBlock:^{
        [self.homeContentVC refreshView];
    }];

}

- (void)testGetFeedAPIPerformance {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self.homeContentVC callGetHomeContentApi];
    }];
}

@end
