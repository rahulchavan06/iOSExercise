//
//  FeedsTableViewCell.m
//  iOSExercise
//
//  Created by Rahul C on 15/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import "FeedsTableViewCell.h"
#import <PureLayout/PureLayout.h>

#define kLabelHorizontalInsets      15.0f
#define kLabelVerticalInsets        10.0f

@interface FeedsTableViewCell ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation FeedsTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [UILabel newAutoLayoutView];
        [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.titleLabel setNumberOfLines:1];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        self.titleLabel.backgroundColor = [UIColor clearColor]; // light blue
        
        self.descriptionLabel = [UILabel newAutoLayoutView];
        [self.descriptionLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.descriptionLabel setNumberOfLines:0];
        [self.descriptionLabel setTextAlignment:NSTextAlignmentLeft];
        [self.descriptionLabel setTextColor:[UIColor darkGrayColor]];
        self.descriptionLabel.backgroundColor = [UIColor clearColor]; // light red
        
        self.feedsImageView = [UIImageView newAutoLayoutView];
        [self.feedsImageView setContentMode:UIViewContentModeScaleAspectFit];
        
        self.contentView.backgroundColor = [UIColor clearColor]; // light green
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.descriptionLabel];
        [self.contentView addSubview:self.feedsImageView];
        
        [self updateFonts];
    }
    
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
//        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//            [self.titleLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
//        }];
        
        [self.feedsImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.feedsImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];
        [self.feedsImageView autoSetDimension:ALDimensionWidth toSize:100.0f];
        [self.feedsImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
        
        [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.titleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.feedsImageView withOffset:kLabelVerticalInsets];
        [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];

        [self.descriptionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:kLabelVerticalInsets];
        
//        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//            [self.descriptionLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
//        }];
        [self.descriptionLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.feedsImageView withOffset:kLabelVerticalInsets];

        [self.descriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        [self.descriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)updateFonts
{
    self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.descriptionLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
}


//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//
//        [self configureTableViewCell];
//    }
//    return self;
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//#pragma mark - Configure UITableViewCell
//
//- (void)configureTableViewCell {
//
//    //Set Feed title
//    self.feedsImageView = [[UIImageView alloc] initForAutoLayout];
//    self.feedsImageView.backgroundColor = [UIColor clearColor];
//    [self.contentView addSubview:self.feedsImageView];
//    //We can set Image scaleAspect as 'ScaleToAspectFill', For showing Full ImageView Size I kept as 'ScaleToAspectFit'
//    [self.feedsImageView setContentMode:UIViewContentModeScaleAspectFit];
//
//    //Set Feed title
//    self.titleLabel = [[UILabel alloc] initForAutoLayout];
//    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
//    self.titleLabel.font = [UIFont boldSystemFontOfSize:FONT_SIZE_21];
//    [self.titleLabel setTextColor:UIColor.darkGrayColor];
//    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
//    [self.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
//    [self.titleLabel setNumberOfLines:0];
//    [self.titleLabel sizeToFit];
//    [self addSubview:self.titleLabel];
//
//    //Set Feed description
//    self.descriptionLabel = [[UILabel alloc] initForAutoLayout];
//    [self.descriptionLabel setBackgroundColor:[UIColor clearColor]];
//    self.descriptionLabel.font = [UIFont systemFontOfSize:FONT_SIZE_17];
//    [self.descriptionLabel setTextColor:UIColor.darkGrayColor];
//    [self.descriptionLabel setTextAlignment:NSTextAlignmentLeft];
//    [self.descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
//    [self.descriptionLabel setNumberOfLines:0];
//    [self.descriptionLabel sizeToFit];
//    [self.contentView addSubview:self.descriptionLabel];
//}

@end
