//
//  PaintCan.m
//  ConveyorPaintPrototype2.1
//
//  Created by Jane Hoffswell on 3/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PaintCan.h"

@implementation PaintCan

@synthesize isTouched;
@synthesize sprite;
@synthesize ratio;

-(id) initWithRatio:(NSMutableArray*) r andPosition:(CGPoint) pos
{
    if( (self=[super init]) ) {
        [self setRatio:r];
        position = pos;
        speed = 0;
        direction = arc4random() % 2*3.1415;
        isTouched = false;
        
        [self setSprite:[CCSprite spriteWithFile:@"Icon-72.png"]];
        self.sprite.position = self->position;
        [self addChild:sprite];
        //[self resizeSpritetoWidth:150 toHeight:105];
        
        NSMutableArray *colorRatio = [self RYBtoRGBConversion:r];
        float Red = [[colorRatio objectAtIndex:0] floatValue];
        float Green = [[colorRatio objectAtIndex:1] floatValue];
        float Blue = [[colorRatio objectAtIndex:2] floatValue];
        
        label = [CCLabelTTF labelWithString:[self ratioToString:r] fontName:@"Marker Felt" fontSize:25];
        label.color = ccc3(Red*255, Green*255, Blue*255);
        label.position = self->position;
        [self addChild: label];
    }
    return self;
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
- (NSMutableArray *)convertToLowestTerms:(NSMutableArray *) r
{
    NSInteger divisor = [self findDivisor:r];
    
    // Compute the new values and create the new array
    int newRed = [[r objectAtIndex:0] intValue]/divisor;
    int newYellow = [[r objectAtIndex:1] intValue]/divisor;
    int newBlue = [[r objectAtIndex:2] intValue]/divisor;
    
    NSMutableArray *newRatio = [self emptyRatioArray];
    [newRatio replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:newRed]];
    [newRatio replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger:newYellow]];
    [newRatio replaceObjectAtIndex:2 withObject:[NSNumber numberWithInteger:newBlue]];
    
    return newRatio;
}

// Determines the greatest common divisor of the input ratio
// Input:  NSMutableArray ratio
// Output: NSInteger of the gcd
- (NSInteger)findDivisor:(NSMutableArray *) r
{
    int red = [[r objectAtIndex:0] intValue];
    int yellow = [[r objectAtIndex:1] intValue];
    int blue = [[r objectAtIndex:2] intValue];
    
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
- (NSString *)ratioToString:(NSMutableArray*) r
{
    // Boudary case checks if the input ratio is of the correct size
    if (r.count == 0) {
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
- (void) colorPaintCans:(UIImageView*) paint:(NSMutableArray *) r
{
    NSMutableArray *colorRatio = [self RYBtoRGBConversion:r];
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

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Touched in paint");
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    if (CGRectContainsPoint( [self.sprite boundingBox], location)) {
            [self setTouched: true];
            return YES;
    }
    return NO;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [self convertTouchToNodeSpace:touch];
    //[self updatePositionWithPoint: location];
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self setTouched: false];
}

-(void) ccTouchCancelled:(NSSet *)touch withEvent:(UIEvent *)event
{
    [self setTouched: false];
}

-(void) setTouched:(bool) b {
    // changes alien color when you pick them up
    isTouched = b;
    if (b) {
        [self.sprite setColor: ccc3(0,155,10)];
    } else {
        [self.sprite setColor: ccc3(255,255,255)];
    }
}

@end
