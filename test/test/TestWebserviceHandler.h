//
//  TestWebserviceHandler.h
//  test
//
//  Created by Bob Ridge on 2016/07/16.
//  Copyright © 2016 Yoco. All rights reserved.
//

#import <Foundation/Foundation.h>
#define WS_NAME                                 @"ws_name"
#define WS_STATUS_CODE                          @"ws_status_code"
#define WS_DATA                                 @"ws_data"
#define WEBSERVICE_NOTIFICATION                 @"webservice_notification"
#define WS_GET_BUSINESS_CATEGORIES              @"getBusinessCategories"

@interface TestWebserviceHandler : NSObject
+(void)getBusinessCategories;
@end
