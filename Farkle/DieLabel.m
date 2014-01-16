//
//  DieLabel.m
//  Farkle
//
//  Created by Sonam Mehta on 1/15/14.
//  Copyright (c) 2014 Sonam Mehta. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(IBAction)labelWasTapped:(id)sender
{
    
    self.backgroundColor = [UIColor redColor];
    [_delegate didChooseDie:self];
}


-(void)lockDie
{
    self.backgroundColor = [UIColor greenColor];
}


-(void)unlockDie
{
    self.backgroundColor = [UIColor blackColor];
}

-(void)roll
{
    int i = arc4random_uniform(6) + 1;
    self.text = [NSString stringWithFormat:@"%i", i];
}


@end
