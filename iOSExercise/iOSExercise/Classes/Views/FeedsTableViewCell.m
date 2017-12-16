//
//  FeedsTableViewCell.m
//  iOSExercise
//
//  Created by Rahul C on 15/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

#import "FeedsTableViewCell.h"
#import "Constants.h"
#import "ContentRows.h"
#import "PureLayout.h"

@implementation FeedsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self configureTableViewCell];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Configure UITableViewCell

- (void)configureTableViewCell/*:(ContentRows*)contentRows*/ {

    //Set Feed title
    self.feedsImageView = [[UIImageView alloc] initForAutoLayout];
    self.feedsImageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.feedsImageView];
    //We can set Image scaleAspect as 'ScaleToAspectFill', For showing Full ImageView Size I kept as 'ScaleToAspectFit'
    [self.feedsImageView setContentMode:UIViewContentModeScaleAspectFit];

    //Set Feed title
    self.titleLabel = [[UILabel alloc] initForAutoLayout];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:FONT_SIZE_21];
    [self.titleLabel setTextColor:UIColor.darkGrayColor];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.titleLabel setNumberOfLines:0];
    [self.titleLabel sizeToFit];
    [self addSubview:self.titleLabel];
     
    //Set Feed description
    self.descriptionLabel = [[UILabel alloc] initForAutoLayout];
    [self.descriptionLabel setBackgroundColor:[UIColor clearColor]];
    self.descriptionLabel.font = [UIFont systemFontOfSize:FONT_SIZE_17];
    [self.descriptionLabel setTextColor:UIColor.darkGrayColor];
    [self.descriptionLabel setTextAlignment:NSTextAlignmentLeft];
    [self.descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.descriptionLabel setNumberOfLines:0];
    [self.descriptionLabel sizeToFit];
    [self.contentView addSubview:self.descriptionLabel];
}

@end
