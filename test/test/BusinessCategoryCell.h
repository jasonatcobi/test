//
//  BusinessCategoryCell.h
//  test
//
//  Created by Bob Ridge on 2016/07/16.
//  Copyright © 2016 Yoco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessCategory.h"

@interface BusinessCategoryCell : UITableViewCell
@property (strong,nonatomic) BusinessCategory* category;
@property (weak, nonatomic) IBOutlet UILabel *mmcLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryGroupLabel;
@end
