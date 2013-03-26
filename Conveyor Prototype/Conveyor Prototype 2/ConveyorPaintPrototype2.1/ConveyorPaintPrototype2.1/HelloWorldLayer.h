//
//  HelloWorldLayer.h
//  ConveyorPaintPrototype2.1
//
//  Created by Jane Hoffswell on 3/4/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "PaintCan.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer {
    CCLayer * conveyorLayer;
    CCSprite * conveyorImage;
    
    PaintCan* movingPaints[50];
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
