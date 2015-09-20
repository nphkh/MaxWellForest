//
//  APIServices.h
//  MaxwellForestExercise
//
//  Created by Khang Nguyen on 20/09/2015.
//  Copyright (c) 2015 Khang Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface APIServices : NSObject

- (void)loadCoffeeListWithCurrentLocation:(CLLocation *)currentLocation
                          completionBlock:(void(^)(NSArray *, NSError *))completionBlock;

@end
