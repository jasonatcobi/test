//
//  BusinessCategory.m
//  test
//
//  Created by Bob Ridge on 2016/07/16.
//  Copyright © 2016 Yoco. All rights reserved.
//

#import "BusinessCategory.h"

@implementation BusinessCategory
-(id)initViaJsonArray:(NSArray *)jsonData{
    if(self = [super init]){
        self.mCCCode = [jsonData objectAtIndex:0];
        self.categoryName = [jsonData objectAtIndex:1];
        self.categoryGroup = [jsonData objectAtIndex:2];
    }
    return self;
}

@end
