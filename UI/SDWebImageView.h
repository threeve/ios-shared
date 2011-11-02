//
//  SDWebImageView.h
//  walmart
//
//  Created by Sam Grover on 2/28/11.
//  Copyright 2011 Set Direction. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface SDWebImageView : UIImageView {
	NSString *imageUrlString;
	UIImage *errorImage;
    ASIHTTPRequest *request;
}

@property (nonatomic, copy) NSString *imageUrlString;
@property (nonatomic, strong) UIImage *errorImage;

@end
