//
//  SDWebService.h
//
//  Created by brandon on 2/14/11.
//  Copyright 2011 Set Direction. All rights reserved.
//

#import <Foundation/Foundation.h>
// this comes from ASI-HTTP
#import "Reachability.h"

typedef void (^SDWebServiceCompletionBlock)(int responseCode, NSString *response, NSError **error);
typedef void (^SDWebServiceGroupCompletionBlock)(NSArray *responseCodes, NSArray *responses, NSError **error);

enum
{
    SDWebServiceErrorNoConnection = 0xBEEF,
    SDWebServiceErrorBadParams = 0x0BADF00D,
    // all other errors come from ASI-HTTP
};

@interface SDWebService : NSObject
{
	NSDictionary *serviceSpecification;
    NSMutableArray *serviceCookies;
    NSMutableDictionary *queues;
    NSUInteger requestCount;
}

@property (nonatomic, strong) NSMutableArray *serviceCookies;

- (id)initWithSpecification:(NSString *)specificationName;
- (BOOL)performRequestWithMethod:(NSString *)requestName routeReplacements:(NSDictionary *)replacements completion:(SDWebServiceCompletionBlock)completionBlock;
- (BOOL)responseIsValid:(NSString *)response forRequest:(NSString *)requestName;
- (NSString *)baseURLInServiceSpecification;
- (BOOL)isReachable:(BOOL)showError;
- (BOOL)isReachableToHost:(NSString *)hostName showError:(BOOL)showError;
- (void)clearCache;
- (void)will302RedirectToUrl:(NSURL *)argUrl;

@end
