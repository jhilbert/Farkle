//
//  DieLabel.h
//  Farkle
//
//  Created by Sonam Mehta on 1/15/14.
//  Copyright (c) 2014 Sonam Mehta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DieLabelDelegate.h"

@interface DieLabel : UILabel
@property id<DieLabelDelegate> delegate;

-(void)roll;
-(void)lockDie;
-(void)unlockDie;


@end
