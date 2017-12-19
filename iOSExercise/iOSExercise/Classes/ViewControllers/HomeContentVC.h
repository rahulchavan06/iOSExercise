//
//  HomeContentVC.h
//  iOSExercise
//
//  Created by Rahul C on 14/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeContentVC : UIViewController



@end

@interface HomeContentVC (Refresh)

- (void)callGetHomeContentApi;
- (void)refreshView;

@end


