//
//  MovingPaint.h
//  ConveyorPaintPrototype2
//
//  Created by Jane Hoffswell on 2/16/13.
//  Copyright (c) 2013 Jane Hoffswell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MovingPaint : CCLayer {
    CGPoint position;
    double speed;
    double direction;
    
    CCLabelTTF* label;
}

@property CCSprite* sprite;
@property bool isTouched;

-(void) setTouched:(bool) b;
-(void) updatePositionWithPoint:(CGPoint) location;
-(void) spriteMoveFinished:(id) sender;

@end
