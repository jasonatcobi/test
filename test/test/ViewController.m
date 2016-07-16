//
//  ViewController.m
//  test
//
//  Created by Bob Ridge on 2016/07/16.
//  Copyright © 2016 Yoco. All rights reserved.
//
#import "TestWebserviceHandler.h"
#import "BusinessCategoryCell.h"
#import "ViewController.h"
#define BUSINESS_CATEGORY_CELL_IDENTIFIER @"businessCategoryCell"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *filterTextField;
@property (strong,nonatomic)NSArray* categories;
@property (strong,nonatomic)NSMutableArray* filteredCategories;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl* refreshControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:WEBSERVICE_NOTIFICATION
                                               object:nil];
    [self fetchCategories];
    
    [self.filterTextField addTarget:self
                  action:@selector(textFieldDidEndEditing:)
        forControlEvents:UIControlEventEditingChanged];
    [self addPullToRefresh];
  }

-(void)addPullToRefresh{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor lightGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(fetchCategories)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];

}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self filterItems];
}
-(void)filterItems{
    self.filteredCategories = [[NSMutableArray alloc]init];
    for(BusinessCategory* category in self.categories){
        if([category.categoryName.lowercaseString hasPrefix:self.filterTextField.text.lowercaseString]){
            [self.filteredCategories addObject:category];
        }
        
    }
    [self.tableView reloadData];
    if(self.refreshControl){
        [self.refreshControl endRefreshing];
    }
}
-(void) fetchCategories{
    
    [TestWebserviceHandler getBusinessCategories];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_filteredCategories count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   BusinessCategoryCell* cell = [tableView dequeueReusableCellWithIdentifier:BUSINESS_CATEGORY_CELL_IDENTIFIER forIndexPath:indexPath];
    
    [cell setCategory:[self.filteredCategories objectAtIndex:indexPath.row]];
    return cell;
}

-(void)receivedNotification:(NSNotification*)data{
    NSDictionary* dictionary = (NSDictionary*)data.object;
    NSNumber* status = [dictionary objectForKey:WS_STATUS_CODE];
    NSString* webserviceName = [dictionary objectForKey:WS_NAME];
    if([status isEqualToNumber:@200] && [webserviceName isEqualToString:WS_GET_BUSINESS_CATEGORIES]){
        self.categories = [dictionary objectForKey:WS_DATA];
        self.filteredCategories =[self.categories mutableCopy];
        [self.tableView reloadData];
        if(self.refreshControl){
            [self.refreshControl endRefreshing];
        }
        
    }
    else{
        NSError* error =[dictionary objectForKey:WS_DATA];
        [[UIAlertController alertControllerWithTitle:@"Error!" message:error.description preferredStyle:UIAlertControllerStyleAlert] showViewController:self sender:nil];
    }
}
@end
