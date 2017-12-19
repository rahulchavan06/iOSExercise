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
#import "ImageUtils.h"


static NSString *CellIdentifier = @"CellIdentifier";

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

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self.feedsTableview reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

// This method is called when the Dynamic Type user setting changes (from the system Settings app)
- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
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
    
    self.feedsTableview.rowHeight = UITableViewAutomaticDimension;
    self.feedsTableview.estimatedRowHeight = 44.0;
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[FeedsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CellIdentifier];

    ContentRows *contentRow = [self.contentData.rows objectAtIndex:indexPath.row];
    // Configure the cell for this indexPath
    [cell updateFonts];
    cell.titleLabel.text =  contentRow.contentTitle;
    cell.descriptionLabel.text = contentRow.contentDescription;
    [ImageUtils downloadUIImageInBackground:contentRow.contentImagePath andCompletionBlock:^(NSData* data){
        cell.feedsImageView.image = [UIImage imageWithData:data];
    }];
    
    // Update constraints to this cell
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];

    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
    }
    
    return cell;
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
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                                    message:@"There are no feeds available."
                                                                   delegate:self
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"OK", nil];
                [alertView show];
            } else if(status == 3) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Try Again!"
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

