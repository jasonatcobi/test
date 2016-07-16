//
//  BusinessCategory.h
//  test
//
//  Created by Bob Ridge on 2016/07/16.
//  Copyright © 2016 Yoco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessCategory : NSObject

@property (strong, nonatomic) NSString* mCCCode;
@property (strong, nonatomic) NSString* categoryName;
@property (strong,nonatomic) NSString* categoryGroup;


-(id)initViaJsonArray:(NSArray *)jsonData;
@end
