//
//  CLLocation+SDExtensions.m
//  walmart
//
//  Created by brandon on 2/16/11.
//  Copyright 2011 Set Direction. All rights reserved.
//

#import "CLLocation+SDExtensions.h"


@implementation CLLocation(SDExtensions)

+ (CLLocation *)locationWithCoordinates:(CLLocationCoordinate2D)coordinates
{
	CLLocation *location = [[[CLLocation alloc] initWithLatitude:coordinates.latitude longitude:coordinates.longitude] autorelease];
	return location;
}

- (CLLocationDistance)getDistanceInCurrentLocaleFrom:(CLLocation *)location
{
	// are we measuring in miles or kilometers?
	NSNumber *unit = [[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem];
	CLLocationDistance distance = [self getDistanceFrom:location];
	
	if (unit)
		distance *= 0.001;
	else
		distance *= 0.000621371192;
	return distance;
}

@end