//
//  HelloWorldLayer.m
//  ConveyorPaintPrototype2.1
//
//  Created by Jane Hoffswell on 3/4/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "PaintCan.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
        // Moving Paint Layer
        conveyorLayer = [CCLayerColor layerWithColor:ccc4(0, 100, 0, 0) width:size.width height:size.height/2 - 30];
        //conveyorImage = [CCSprite spriteWithFile: @"Default-Landscape~ipad.png"];
        //conveyorImage.anchorPoint = ccp(0,0);
        //conveyorImage.scaleY = size.height / conveyorImage.contentSize.height;
        //conveyorImage.scaleX = size.width / conveyorImage.contentSize.width;
        //[conveyorLayer addChild: conveyorImage];
        [self addChild:conveyorLayer];
        
        [self setup: 10 PaintWithLevel: 0];
        
        // Game loop update
        [self schedule:@selector(gameLoop:) interval: 1/60.0f];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Touched in Hello");
    // handles touch (so the pause button can be poked as well as the aliens).
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    // check if pause button is pressed
    if (FALSE) {
        return YES;
    }
    return NO;
}

-(void) setup: (int) numAliens PaintWithLevel: (int) level {
    for(int i =0; i < 10; ++i) {
        movingPaints[i] = [[PaintCan alloc] initWithRatio:[self randomPaintRatio]
                                              andPosition:CGPointMake(arc4random() % (int)conveyorLayer.contentSize.width, arc4random() % (int)conveyorLayer.contentSize.height)];
        //movingPaints[i].position = CGPointMake(100, i*100);
        [conveyorLayer addChild: movingPaints[i]];
    }
}

// Creates an empty/default ratio array
// Input:  none
// Output: NSMutableArray with ratio 0:0:0
- (NSMutableArray*)emptyRatioArray
{
    NSNumber *zero = [NSNumber numberWithInteger:[@"0" intValue]];
    NSMutableArray* temp = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < 3; i++) {
        if (temp.count > i) {
            [temp replaceObjectAtIndex:i withObject:zero];
        } else {
            [temp addObject:zero];
        }
    }
    return temp;
}

// Converts the input ratio to lowest terms
// Input:  NSMutableArray ratio of RYB numbers
// Output: NSMutableArray of the ratio in lowest terms
- (NSMutableArray *)convertToLowestTerms:(NSMutableArray *) ratio
{
    NSInteger divisor = [self findDivisor:ratio];
    
    // Compute the new values and create the new array
    int newRed = [[ratio objectAtIndex:0] intValue]/divisor;
    int newYellow = [[ratio objectAtIndex:1] intValue]/divisor;
    int newBlue = [[ratio objectAtIndex:2] intValue]/divisor;
    
    NSMutableArray *newRatio = [self emptyRatioArray];
    [newRatio replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:newRed]];
    [newRatio replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:newYellow]];
    [newRatio replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:newBlue]];
    
    return newRatio;
}

// Determines the greatest common divisor of the input ratio
// Input:  NSMutableArray ratio
// Output: NSInteger of the gcd
- (NSInteger)findDivisor:(NSMutableArray *) ratio
{
    int red = [[ratio objectAtIndex:0] intValue];
    int yellow = [[ratio objectAtIndex:1] intValue];
    int blue = [[ratio objectAtIndex:2] intValue];
    
    int temp = [self gcd:red :yellow];
    int divisor = [self gcd:temp :blue];
    
    // Boudary case for ratio with two zeroes (in which case the divisor found
    // above is incorrectly found as 1)
    if (red == 0 && yellow == 0 && blue != 0) {
        divisor = blue;
    } else if (red != 0 && yellow == 0 && blue == 0) {
        divisor = red;
    }else if (red == 0 && yellow !=0 && blue == 0) {
        divisor = yellow;
    }
    
    return divisor;
}

// Finds the greatest common divisor
// Adapted from: http://stackoverflow.com/questions/5279466/greatest-common-factor-on-objective-c
// Input:  int x and y to be compared
// Output: int representing greates common divisor
- (int)gcd:(int) m:(int) n
{
    // Boundary case for inputs of 0
    if (m == 0 && n == 0) {
        return 1;
    } else if (m == 0) {
        return n;
    } else if (n == 0) {
        return m;
    }
    
    int temp = 0;
    int r = 0;
    
    if (m < n) {
        temp = m;
        m = n;
        n = temp;
    }
    
    r = m % n;
    
    if (r == 0) {
        return n;
    } else {
        return [self gcd:n :r];
    }
}

// Converts a ratio to a printable string
// Input:  UILabel label to be changed to the given NSMutableArray ratio
// Output: NSString of the formated ratio
- (NSString *)ratioToString:(NSMutableArray*) ratio
{
    // Boudary case checks if the input ratio is of the correct size
    if (ratio.count == 0) {
        return @"Error: Ratio is empty.";
    } else {
        // Loop through the ratio array to create a string of the form "_:_:_"
        NSString *newRatio = @"";
        for (int i = 0; i < 3; i++) {
            NSString *myString = [[ratio objectAtIndex:i] stringValue];
            newRatio = [newRatio stringByAppendingString:myString];
            if (i < 2) {
                newRatio = [newRatio stringByAppendingString:@":"];
            }
        }
        return newRatio;
    }
    
}

// Saves the necessary colors and computes the new paint can image
// Input:  UIImageView representing the paint area and NSString key for the ratio
// Output: none
- (void) colorPaintCans:(UIImageView*) paint:(NSMutableArray *) ratio
{
    NSMutableArray *colorRatio = [self RYBtoRGBConversion:ratio];
    float Red = [[colorRatio objectAtIndex:0] floatValue];
    float Green = [[colorRatio objectAtIndex:1] floatValue];
    float Blue = [[colorRatio objectAtIndex:2] floatValue];
    paint.image = [self getImageWithTintedColor:paint.image
                                       withTint:[UIColor colorWithRed:Red
                                                                green:Green
                                                                 blue:Blue
                                                                alpha:1.0]
                                  withIntensity:1.0];
}

// Colors the image of the paint fill area with the given color
// Input:  the UIColor to be used for the fill and its float intensity
// Output: the modified UIImage
- (UIImage *) getImageWithTintedColor:(UIImage *)image withTint:(UIColor *)color withIntensity:(float)alpha
{
    CGSize size = image.size;
    
    UIGraphicsBeginImageContextWithOptions(size, FALSE, 2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [image drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:1.0];
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextSetAlpha(context, alpha);
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(CGPointZero.x, CGPointZero.y, image.size.width, image.size.height));
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

// Converts between RYB and RGB color ratios
// Adapted from: https://github.com/ddelruss/UIColor-Mixing/blob/master/UIColorMixExample/UIColor%2BMixing.m
// Input:  NSMutableArray of the RYB colors
// Output: NSMutableArray of the RGB colors
- (NSMutableArray *)RYBtoRGBConversion: (NSMutableArray *) rybColor
{
    float oldRed = [[rybColor objectAtIndex:0] floatValue];
    float oldYellow = [[rybColor objectAtIndex:1] floatValue];
    float oldBlue = [[rybColor objectAtIndex:2] floatValue];
    
    NSMutableArray *rgbColor = [NSMutableArray arrayWithCapacity:3];
    
    if (oldRed == oldYellow && oldYellow == oldBlue && oldRed != 0) {
        
        // If the numbers are equal, the color should be brown not white
        [rgbColor addObject:[NSNumber numberWithFloat:0.4]];
        [rgbColor addObject:[NSNumber numberWithFloat:0.2]];
        [rgbColor addObject:[NSNumber numberWithFloat:0.0]];
        
    } else {
        
        NSInteger temp = MAX(oldRed, oldYellow);
        float maximum = MAX(temp,oldBlue);
        
        float r, y, b, g, w, my, mg, n;
        r = oldRed/maximum;
        y = oldYellow/maximum;
        b = oldBlue/maximum;
        
        // remove whiteness
        w = MIN(r, MIN(y,b));
        r -= w;
        y -= w;
        b -= w;
        
        my = MAX(r, MAX(y,b));
        
        // Get the green out of the yellow and blue
        g = MIN(y, b);
        y -= g;
        b -= g;
        
        if (b && g) {
            b *= 2.0;
            g *= 2.0;
        }
        
        // Redistribute the remaining yellow.
        r += y;
        g += y;
        
        // Normalize to values.
        mg = MAX(r, MAX(g, b));
        if (mg) {
            n = my / mg;
            r *= n;
            g *= n;
            b *= n;
        }
        
        // Add the white back in.
        r += w;
        g += w;
        b += w;
        
        [rgbColor addObject:[NSNumber numberWithFloat:r]];
        [rgbColor addObject:[NSNumber numberWithFloat:g]];
        [rgbColor addObject:[NSNumber numberWithFloat:b]];
        
    }
    
    return rgbColor;
}

// Creates a random ratio with maximum integer 2
// Input:  none
// Output: a NSMutableArray containing the new paint ratio
- (NSMutableArray *)randomPaintRatio
{
    // Should be set to one more than desired max int
    int MAX_RATIO_INT = 5;
    
    // Randomly generate three numbers with max number 2 (magic)
    // and add them to an array
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < 3; i++) {
        NSInteger randomInteger = arc4random() % MAX_RATIO_INT;
        NSNumber *randomNumber = [NSNumber numberWithInteger:randomInteger];
        [array addObject:randomNumber];
    }
    
    array = [self convertToLowestTerms:array];
    
    // Regenerate numbers if the ratio is 0:0:0 (free win) or the same as the previous ratio
    /*if ([array isEqualToArray:[self emptyRatioArray]] || [array isEqualToArray:paintChipRatio]) {
     array = [self randomPaintRatio];
     }*/
    
    //paintChipRatio = array;
    //[self colorPaintCans:paintChip:paintChipRatio];
    return array;
}

-(void) gameLoop: (ccTime) dT
{
    // Check if alien is in portal
    for(int i =0; i < 10; ++i) {
        // Alienlayer is a bit too tall relative to its graphic so we shrink the size aliens knows about..
        //[movingPaints[i] updatePosition: dT givenBounds: CGSizeMake(alienLayer.contentSize.width, alienLayer.contentSize.height-35)];
        if ( movingPaints[i].isTouched ) {
            NSLog(@"Touched");
        }
    }   
}

@end
