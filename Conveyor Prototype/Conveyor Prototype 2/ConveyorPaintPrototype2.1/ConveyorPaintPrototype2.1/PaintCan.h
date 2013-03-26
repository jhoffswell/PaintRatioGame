//
//  PaintCan.h
//  ConveyorPaintPrototype2.1
//
//  Created by Jane Hoffswell on 3/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PaintCan : CCLayer {
    double speed;
    double direction;
    CCLabelTTF* label;
    CGPoint position;
}

@property bool isTouched;
@property(retain) CCSprite* sprite;
@property(retain) NSMutableArray* ratio;

-(void) setTouched:(bool) b;
//-(void) updatePositionWithPoint:(CGPoint) location;
//-(void) spriteMoveFinished:(id) sender;

@end
