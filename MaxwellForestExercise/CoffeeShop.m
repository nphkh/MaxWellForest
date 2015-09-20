//
//  CoffeeShop.m
//  MaxwellForestExercise
//
//  Created by Khang Nguyen on 20/09/2015.
//  Copyright (c) 2015 Khang Nguyen. All rights reserved.
//

#import "CoffeeShop.h"

@interface CoffeeShop()

@property(nonatomic, strong, readwrite) NSString *name;
@property(nonatomic, strong, readwrite) NSString *address;
@property(nonatomic, strong, readwrite) NSNumber *phoneNumber;
@property(nonatomic, strong, readwrite) CLLocation *location;

@end

@implementation CoffeeShop

- (instancetype)initWithName:(NSString *)name
                     address:(NSString *)address
                 phoneNumber:(NSNumber *)phoneNumber
                    location:(CLLocation *)location
{
    if(self = [super init])
    {
        _name = name;
        _address = address;
        _phoneNumber = phoneNumber;
        _location = location;
    }
    
    return self;
}

@end
