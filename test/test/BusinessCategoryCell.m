//
//  BusinessCategoryCell.m
//  test
//
//  Created by Bob Ridge on 2016/07/16.
//  Copyright © 2016 Yoco. All rights reserved.
//

#import "BusinessCategoryCell.h"

@implementation BusinessCategoryCell
-(void)setCategory:(BusinessCategory *)category{
    _category = category;
    self.mmcLabel.text = category.mCCCode;
    self.categoryNameLabel.text = category.categoryName;
    self.categoryGroupLabel.text = category.categoryGroup;
}
@end
