//
//  ViewController.h
//  ConveytorPaintPrototype
//
//  Created by Jane Hoffswell on 2/1/13.
//  Copyright (c) 2013 Jane Hoffswell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    UIImageView* source1;
    UIImageView* source2;
    
    // Mix Can
    UIImageView* mixCan1;
    UILabel* mixCanLabel1;
    NSMutableArray* mixCanRatio1;
    
    UIImageView* mixCan2;
    UILabel* mixCanLabel2;
    NSMutableArray* mixCanRatio2;
    
    UIImageView* mixCan3;
    UILabel* mixCanLabel3;
    NSMutableArray* mixCanRatio3;
    
    // Goal Color
    UIImageView* paintChip1;
    UILabel* paintChipLabel1;
    NSMutableArray* paintChipRatio1;
    
    UIImageView* paintChip2;
    UILabel* paintChipLabel2;
    NSMutableArray* paintChipRatio2;
    
    UIImageView* paintChip3;
    UILabel* paintChipLabel3;
    NSMutableArray* paintChipRatio3;
    
    NSMutableArray* selectedColor;
    CGPoint startLocation;
}

@end
