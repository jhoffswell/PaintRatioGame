//
//  MovingPaint.m
//  ConveyorPaintPrototype2
//
//  Created by Jane Hoffswell on 2/16/13.
//  Copyright (c) 2013 Jane Hoffswell. All rights reserved.
//

#import "MovingPaint.h"

@implementation MovingPaint

@synthesize isTouched;

-(id) initWithPosition:(CGPoint) pos
{
    if(self = [super init]) {
        position = pos;
        speed = 0;
        direction = arc4random() % 2*3.1415;
        isTouched = false;
        
        [self setSprite:[CCSprite spriteWithSpriteFrameName:@"paintFillImage.png"]];
        
        self.sprite.position = self->position;
        [self resizeSpriteToWidth:200 toHeight:200];
        
        [self updateLabel];
        [self addChild: label];

    }
    
    return self;
}

-(void) onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}



@end
