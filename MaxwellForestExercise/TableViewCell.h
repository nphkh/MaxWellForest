//
//  TableViewCell.h
//  MaxwellForestExercise
//
//  Created by Khang Nguyen on 20/09/2015.
//  Copyright (c) 2015 Khang Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

@class CoffeeShop;

@interface TableViewCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *nameLabel;
@property(nonatomic, weak) IBOutlet UILabel *addressLabel;
@property(nonatomic, weak) IBOutlet UILabel *distanceLabel;

- (void)configureCellWithShop:(CoffeeShop *)shop
                     distance:(CLLocationDistance)distance;

@end
