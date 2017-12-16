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
#import "FeedsTableViewCell.h"
#import "PureLayout.h"

@interface HomeContentVC () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) Content *contentData;
@property(nonatomic, strong) UITableView *feedsTableview;
@property(nonatomic, strong) NSMutableArray *rowHeight;

@end

@implementation HomeContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Call fetch content Api
    [self callGetHomeContentApi];
    
    //Add Right Bar Button to NavigationBar to Refresh View
    UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc]initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refreshView)];
    self.navigationItem.rightBarButtonItem=refreshBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self.feedsTableview reloadData];
}

#pragma mark - Refresh View

- (void)refreshView {

    //Call fetch content Api to refresh view
    [self callGetHomeContentApi];
}

#pragma mark - Create UI

- (void)createFeedTableView {
    //Create Feeds TableView
    self.feedsTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.feedsTableview.delegate = self;
    self.feedsTableview.dataSource = self;
    self.feedsTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.feedsTableview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.feedsTableview];
}

#pragma mark - UITableView Delegates & Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentData.rows.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self calculateCellHeight:indexPath.row]+20;
}

- (CGFloat)calculateCellHeight:(NSInteger)rowId {
    //Calculate table row cell Height
    ContentRows *contentRow = [self.contentData.rows objectAtIndex: rowId];
    CGFloat height = [self calculateTextHeight:contentRow.contentTitle withFontSize:21.0];
    height = height + [self calculateTextHeight:contentRow.contentDescription withFontSize:17.0];
    height = height;
    return height;
}

- (CGFloat)calculateTextHeight:(NSString*)text withFontSize:(CGFloat)fontSize {
    //Calculate Text height
    UIFont *font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:fontSize];
    CGSize constraint = CGSizeMake(self.feedsTableview.frame.size.width-120,9999);
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:constraint
                                       options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                    attributes:attributes
                                       context:nil];
    return rect.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableViewCellIdentifier = @"FeedsTableViewCell";
    FeedsTableViewCell *cell = (FeedsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    ContentRows *contentRow = [self.contentData.rows objectAtIndex:indexPath.row];
    
    cell = [[FeedsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:tableViewCellIdentifier];

    // Configure the cell...

    //Call Async task to Load Feed Image
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:contentRow.contentImagePath]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        cell.feedsImageView.image = [UIImage imageWithData:data];
    }];
    
    //Set Feed data
    cell.titleLabel.text = contentRow.contentTitle;
    [cell.descriptionLabel setText:contentRow.contentDescription];

    //Adjust table constraints
    [self setTableViewCellConstraints:cell withIndexPath:indexPath];
    
    //Set Cell properties to set alternate background color and cell selection style
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
    }
    return cell;
}

#pragma mark - set UITableViewCell Constraints

- (void)setTableViewCellConstraints:(FeedsTableViewCell*)cell withIndexPath:(NSIndexPath*)indexpath {
    [cell.feedsImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0f];
    [cell.feedsImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.0f];
    [cell.feedsImageView autoSetDimension:ALDimensionWidth toSize:90.0];
    [cell.feedsImageView autoSetDimension:ALDimensionHeight toSize:[self calculateCellHeight:indexpath.row]];
    
    [cell.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    [cell.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:110];
    [cell.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.0];
    [cell.titleLabel autoSetDimension:ALDimensionHeight toSize:[self calculateTextHeight:cell.titleLabel.text withFontSize:FONT_SIZE_21]];
    
    [cell.descriptionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cell.titleLabel];
    [cell.descriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:110.0];
    [cell.descriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [cell.descriptionLabel autoSetDimension:ALDimensionHeight toSize:[self calculateTextHeight:cell.descriptionLabel.text withFontSize:FONT_SIZE_19]];
}

#pragma mark - Web service call

- (void)callGetHomeContentApi {
    
    //Call GetContent Feeds data web service through completion handler
    if ([NetworkUtils isNetworkAvailable]) {
        [HomeContentService callGetContentFeedData:@"" andCompletionBlock:^(ServiceStatus status, Content *content) {
            if(status == 1) {
                self.contentData = content;
                self.navigationItem.title = self.contentData.title;
                [self createFeedTableView];
            } else if(status == 2) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                                    message:@"There are no feeds available."
                                                                   delegate:self
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"OK", nil];
                [alertView show];
            } else if(status == 3) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                                    message:@"Request is Timed Out, Please try again."
                                                                   delegate:self
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"OK", nil];
                [alertView show];
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

