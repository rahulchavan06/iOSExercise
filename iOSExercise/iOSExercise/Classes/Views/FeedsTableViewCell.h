//
//  FeedsTableViewCell.h
//  iOSExercise
//
//  Created by Rahul C on 15/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedsTableViewCell : UITableViewCell

@property(strong, nonatomic) UILabel *titleLabel;
@property(strong, nonatomic) UILabel *descriptionLabel;
@property(nonatomic, strong) UIImageView *feedsImageView;

- (void)updateFonts;

@end





