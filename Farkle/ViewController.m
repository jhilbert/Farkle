//
//  ViewController.m
//  Farkle
//
//  Created by Sonam Mehta on 1/15/14.
//  Copyright (c) 2014 Sonam Mehta. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"
#import "DieLabelDelegate.h"

@interface ViewController () <DieLabelDelegate>

{
    NSMutableArray *dice;
    __weak IBOutlet UILabel *pointsCollected;
    __weak IBOutlet UILabel *playerName;
    __weak IBOutlet UILabel *totalPoints;
    NSInteger pointsCollectedNumber;
    NSInteger totalPointsCollected;
    NSInteger currentPlayer;
    NSMutableArray *players;
    NSMutableArray *totals;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	dice = [NSMutableArray array];
    pointsCollectedNumber = 0;
    totalPointsCollected = 0;
    currentPlayer = 0;
    
    players = [NSMutableArray array];
    [players addObject:@"Player 1"];
    [players addObject:@"Player 2"];
    
    totals = [NSMutableArray array];
    for (int i = 0;i < players.count; i++)
    {
        [totals addObject:[NSString stringWithFormat:@"%i", totalPointsCollected]];
    }
    [self nextPlayer];
}

- (IBAction)onRollButtonPressed:(id)sender
{
    NSString *num = pointsCollected.text;
    pointsCollectedNumber = [num intValue];
    
    pointsCollectedNumber += [self countPoints];
    if (pointsCollectedNumber == 0)
    {
        [self nextPlayer];
    }
    else
    {
        pointsCollected.text = [NSString stringWithFormat:@"%i",pointsCollectedNumber];
        
        for (DieLabel *label in self.view.subviews)
        {
            if ([label isKindOfClass:[DieLabel class]])
            {
                if(![dice containsObject:label])
                {
                    [label roll];
                    
                    label.delegate = self;
                }
            }
            
        }
    }
    dice = [NSMutableArray array];
}

- (IBAction)onTakePoints:(id)sender {
    totalPointsCollected = [totalPoints.text intValue];
    
    totalPointsCollected += pointsCollectedNumber;
    totalPoints.text = [NSString stringWithFormat:@"%i",totalPointsCollected];
    for (DieLabel *label in self.view.subviews)
    {
        if ([label isKindOfClass:[DieLabel class]])
        {
            [label unlockDie];
        }
    }
    dice = [NSMutableArray array];
    pointsCollectedNumber = 0;
    pointsCollected.text = [NSString stringWithFormat:@"%i",pointsCollectedNumber];
    
}

-(void)didChooseDie:(DieLabel *)dieLabel
{
    [dieLabel lockDie];
    [dice addObject:dieLabel];
}

-(NSInteger)countPoints
{
    NSInteger points = 0;
    NSMutableString *myDice = [NSMutableString new];
    for (DieLabel *dieLabel in dice)
    {
        [myDice appendString:dieLabel.text];
    }
    
    if ([myDice isEqualToString:@""])
        return 0;
    
    for (int number = 1; number < 7; number++)
    {
        NSString *numberString = [NSString stringWithFormat:@"%i",number];
        NSInteger count = [self numberOfOccurances:numberString inString:myDice];
        if (count >=3)
        {
            switch (number) {
                case 1:
                    points=points+1000+(6-count)*100;
                    break;
                case 2:
                    points=points+200;
                    break;
                case 3:
                    points=points+300;
                    break;
                case 4:
                    points=points+400;
                    break;
                case 5:
                    points=points+500+(6-count)*50;
                    break;
                case 6:
                    points=points+600;
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            switch (number) {
                case 1:
                    points=points+count*100;
                    break;
                case 5:
                    points=points+count*50;
                    break;
                default:
                    break;
            }
        }
        
    }
    
    return points;
}

-(int)numberOfOccurances:(NSString*) searchCharacter inString:(NSString*)string
{
    int count = 0;
    NSString *extract;
    NSRange rangeToExtract;
    if (string == nil)
        return 0;
    
    for (int i=0; i< (string.length - searchCharacter.length + 1); i++)
    {
        rangeToExtract = NSMakeRange(i, searchCharacter.length);
        extract = [string substringWithRange:rangeToExtract];
        if ([extract isEqualToString:searchCharacter])
            count++;
    }
    return count;
}

-(void)nextPlayer
{
    if (currentPlayer == players.count)
    {
        currentPlayer = 0;
    }
    playerName.text = [players objectAtIndex:currentPlayer];
    
    NSString *totalPointsCollectedString = [totals objectAtIndex:currentPlayer];
    totalPointsCollected = [totalPointsCollectedString intValue];
    totalPoints.text = [NSString stringWithFormat:@"%i",totalPointsCollected];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
