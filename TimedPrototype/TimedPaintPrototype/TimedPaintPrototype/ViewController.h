//
//  ViewController.h
//  TimedPaintPrototype
//
//  Created by Jane Hoffswell on 2/1/13.
//  Copyright (c) 2013 Jane Hoffswell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate> {
    UILabel* timerLabel;
    NSTimer* timer;
    int timerCount;
    bool timerPaused;
    
    UIButton* pauseButton;
    
    int turns;
    UILabel* turnsLabel;
    
    // Paint Cans
    UIImageView* source1;
    UIImageView* source2;
    UIImageView* source3;
    
    UILabel* sourceLabel1;
    UILabel* sourceLabel2;
    UILabel* sourceLabel3;
    
    UIImageView* mixCan;
    UILabel* mixCanLabel;
    NSMutableArray* mixCanRatio;
    
    // Goal Color
    UIImageView* paintChip;
    UILabel* paintChipLabel;
    NSMutableArray* paintChipRatio;
    
    NSMutableArray* selectedColor;
}

@end
