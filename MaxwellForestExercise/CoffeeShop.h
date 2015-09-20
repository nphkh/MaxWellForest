//
//  CoffeeShop.h
//  MaxwellForestExercise
//
//  Created by Khang Nguyen on 20/09/2015.
//  Copyright (c) 2015 Khang Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface CoffeeShop : NSObject

@property(nonatomic, strong, readonly) NSString *name;
@property(nonatomic, strong, readonly) NSString *address;
@property(nonatomic, strong, readonly) NSNumber *phoneNumber;
@property(nonatomic, strong, readonly) CLLocation *location;

- (instancetype)initWithName:(NSString *)name
                     address:(NSString *)address
                 phoneNumber:(NSNumber *)phoneNumber
                    location:(CLLocation *)location;

@end
