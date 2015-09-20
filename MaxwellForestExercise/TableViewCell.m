//
//  TableViewCell.m
//  MaxwellForestExercise
//
//  Created by Khang Nguyen on 20/09/2015.
//  Copyright (c) 2015 Khang Nguyen. All rights reserved.
//

#import "TableViewCell.h"

#import "CoffeeShop.h"

@interface TableViewCell()

@property(nonatomic, strong) CLLocation *location;
@property(nonatomic, strong) CoffeeShop *shop;

@end

@implementation TableViewCell

- (IBAction)showOnMap:(id)sender
{
    if(self.location)
    {
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?q=%f,%f", self.location.coordinate.latitude, self.location.coordinate.longitude]];
    
        [[UIApplication sharedApplication] openURL:URL];
    }
}

- (IBAction)callShop:(id)sender
{
    if(self.shop.phoneNumber)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"telprompt://" stringByAppendingString:self.shop.phoneNumber.stringValue]]];
    }
}

- (void)configureCellWithShop:(CoffeeShop *)shop
                     distance:(CLLocationDistance)distance
{
    self.location = shop.location;
    self.nameLabel.text = [NSString stringWithFormat:@"Name : %@", shop.name];
    self.addressLabel.text = [NSString stringWithFormat:@"Address : %@", shop.address];
    self.distanceLabel.text = [NSString stringWithFormat:@"Distance : %f metres", distance];
    
    [self layoutIfNeeded];
}

@end
