//
//  TestWebserviceHandler.m
//  test
//
//  Created by Bob Ridge on 2016/07/16.
//  Copyright © 2016 Yoco. All rights reserved.
//

#import "TestWebserviceHandler.h"
#import "BusinessCategory.h"
#import <AFNetworking/AFHTTPSessionManager.h>


#define baseUrl                                 @"https://yoco-core-staging.herokuapp.com/api/common/v1/"


@implementation TestWebserviceHandler
+(void)notifyObserver:(NSString*)webserviceName statusCode:(long)status data:(NSObject*)data{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:WEBSERVICE_NOTIFICATION object:[NSDictionary dictionaryWithObjectsAndKeys:webserviceName, WS_NAME, [NSNumber numberWithLong:status], WS_STATUS_CODE, data,WS_DATA,nil]];

}

+(void)getBusinessCategories{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
   
    NSString* url =[NSString stringWithFormat:@"%@properties/businessCategories",baseUrl];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber* status = [responseObject objectForKey:@"status"];
        if([status isEqualToNumber:@200]){
            NSArray* items = [responseObject objectForKey:@"data"];
            NSMutableArray* parsedItems = [[NSMutableArray alloc]init];
            
            
            for(NSArray* item in items){
                BusinessCategory* category = [[BusinessCategory alloc]initViaJsonArray:item];
                [parsedItems addObject:category];
            }
            
            [self notifyObserver:WS_GET_BUSINESS_CATEGORIES statusCode:[status longValue] data:parsedItems];
            
        }
        else{
           // [self notifyObserver:WS_GET_BUSINESS_CATEGORIES statusCode:[status longValue] data:error];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSInteger statusCode = 0;
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        
        if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
            statusCode = httpResponse.statusCode;
           
        }
         [self notifyObserver:WS_GET_BUSINESS_CATEGORIES statusCode:statusCode data:error];
    }];

}
@end
