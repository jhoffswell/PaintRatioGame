//
//  ViewController.m
//  ConveytorPaintPrototype
//
//  Created by Jane Hoffswell on 2/1/13.
//  Copyright (c) 2013 Jane Hoffswell. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self createPaintWithMovement:true];
    
    [self initalizeDestinationPaint];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPaintWithMovement:(bool) mov
{
    NSMutableArray* array1 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    source1 = [[UIImageView alloc] initWithFrame:CGRectMake(-200, 50, 200, 200)];
    source1.image = [UIImage imageNamed:@"paintFillImage.png"];
    [self colorPaintCans:source1 :array1];
    [source1 setUserInteractionEnabled:TRUE];
    
    if (mov) {
        [UIImageView animateWithDuration:15.0f
                                   delay:0.0
                                 options: UIViewAnimationOptionAllowUserInteraction
                              animations:^{[source1 setCenter:CGPointMake(2000, 50)];}
                              completion:nil];
    }
    [source1 setCenter:CGPointMake(250, 100)];
    source1.tag = 1;
    
    [self.view addSubview:source1];
    
    NSMutableArray* array2 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], nil];
    source2 = [[UIImageView alloc] initWithFrame:CGRectMake(-200, 50, 200, 200)];
    source2.image = [UIImage imageNamed:@"paintFillImage.png"];
    [self colorPaintCans:source2 :array2];
    [source2 setUserInteractionEnabled:TRUE];
    
    if (mov) {
        [UIImageView animateWithDuration:15.0f
                                   delay:5.0
                                 options: UIViewAnimationOptionAllowUserInteraction
                              animations:^{[source2 setCenter:CGPointMake(2000, 50)];}
                              completion:nil];
    }
    [source2 setCenter:CGPointMake(1000, 50)];
    source2.tag = 2;
    
    [self.view addSubview:source2];
}

- (void)initalizeDestinationPaint
{
    
    // Initialize the destination paint can
    mixCanRatio1 = [self emptyRatioArray];
    mixCanLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(300, 400, 100, 100)];
    [mixCanLabel1 setTextColor:[UIColor blueColor]];
    [mixCanLabel1 setText:[self ratioToString:mixCanRatio1]];
    [self.view addSubview:mixCanLabel1];
    
    mixCan1 = [[UIImageView alloc] initWithFrame:CGRectMake(225, 450, 200, 200)];
    mixCan1.image = [UIImage imageNamed:@"paintFillImage.png"];
    [self colorPaintCans:mixCan1:mixCanRatio1];
    [self.view addSubview:mixCan1];
    
    mixCanRatio2 = [self emptyRatioArray];
    mixCanLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(500, 400, 100, 100)];
    [mixCanLabel2 setTextColor:[UIColor blueColor]];
    [mixCanLabel2 setText:[self ratioToString:mixCanRatio2]];
    [self.view addSubview:mixCanLabel2];
    
    mixCan2 = [[UIImageView alloc] initWithFrame:CGRectMake(425, 450, 200, 200)];
    mixCan2.image = [UIImage imageNamed:@"paintFillImage.png"];
    [self colorPaintCans:mixCan2:mixCanRatio2];
    [self.view addSubview:mixCan2];
    
    mixCanRatio3 = [self emptyRatioArray];
    mixCanLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(700, 400, 100, 100)];
    [mixCanLabel3 setTextColor:[UIColor blueColor]];
    [mixCanLabel3 setText:[self ratioToString:mixCanRatio3]];
    [self.view addSubview:mixCanLabel3];
    
    mixCan3 = [[UIImageView alloc] initWithFrame:CGRectMake(625, 450, 200, 200)];
    mixCan3.image = [UIImage imageNamed:@"paintFillImage.png"];
    [self colorPaintCans:mixCan3:mixCanRatio3];
    [self.view addSubview:mixCan3];
    
    // Initialize the paint chip
    paintChipRatio1 = [self randomPaintRatio];
    paintChipLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(350, 650, 100, 100)];
    [paintChipLabel1 setTextColor:[UIColor blueColor]];
    [paintChipLabel1 setText:[self ratioToString:paintChipRatio1]];
    [self.view addSubview:paintChipLabel1];
    
    paintChip1 = [[UIImageView alloc] initWithFrame:CGRectMake(250, 650, 100, 100)];
    paintChip1.image = [UIImage imageNamed:@"paintFillImage.png"];
    [self colorPaintCans:paintChip1:paintChipRatio1];
    [self.view addSubview:paintChip1];
    
    paintChipRatio2 = [self randomPaintRatio];
    paintChipLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(550, 650, 100, 100)];
    [paintChipLabel2 setTextColor:[UIColor blueColor]];
    [paintChipLabel2 setText:[self ratioToString:paintChipRatio2]];
    [self.view addSubview:paintChipLabel2];
    
    paintChip2 = [[UIImageView alloc] initWithFrame:CGRectMake(450, 650, 100, 100)];
    paintChip2.image = [UIImage imageNamed:@"paintFillImage.png"];
    [self colorPaintCans:paintChip2:paintChipRatio2];
    [self.view addSubview:paintChip2];
    
    paintChipRatio3 = [self randomPaintRatio];
    paintChipLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(750, 650, 100, 100)];
    [paintChipLabel3 setTextColor:[UIColor blueColor]];
    [paintChipLabel3 setText:[self ratioToString:paintChipRatio3]];
    [self.view addSubview:paintChipLabel3];
    
    paintChip3 = [[UIImageView alloc] initWithFrame:CGRectMake(650, 650, 100, 100)];
    paintChip3.image = [UIImage imageNamed:@"paintFillImage.png"];
    [self colorPaintCans:paintChip3:paintChipRatio3];
    [self.view addSubview:paintChip3];
}

// Checks if the ratio has been correctly computed
// Input:  none
// Output: none
- (void)checkWinCondition
{
    //NSMutableArray *checkArray = [self convertToLowestTerms:mixCanRatio];
    //if ([checkArray isEqualToArray:paintChipRatio]) {
        
        //turns++;
        //[turnsLabel setText:[NSString stringWithFormat:@"Turns: %d", turns]];
        
        //[_victoryLabel setText:@"Congratulations! You found the correct ratio!"];
        [self performSelector:@selector(updateScreenForWin) withObject:nil afterDelay:1];
    //}
}

- (void)updateScreenForWin
{
    /*paintChipRatio = [self randomPaintRatio];
    [paintChipLabel setText:[self ratioToString:paintChipRatio]];
    
    mixCanRatio = [self emptyRatioArray];
    [mixCanLabel setText:[self ratioToString:mixCanRatio]];
    [self colorPaintCans:mixCan:mixCanRatio];*/
    
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
    int MAX_RATIO_INT = 2;
    
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

// Adapted from online tutorial: iPhone Programming Tutorial – Using UITouch To Drag An Image Around The Screen
// Calculates the location of touch down
// Input:  NSSet touches and UIEvent event
// Output: none
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:touch.view];
    //startLocation = [touch locationInView:source1];
    
    /*if (touch.view.tag == 1) {
        NSLog(@"Touched red");
    } else if (touch.view.tag == 2) {
        NSLog(@"Touched yellow");
    } else {
        NSLog(@"Touched somewhere else");
    }*/
    
    if (touch.view.tag == 1) {
        startLocation = [touch locationInView:touch.view];
        [UIView animateWithDuration:0.0f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^ {source1.center = CGPointMake(startLocation.x, startLocation.y);}
                         completion:^(BOOL complete) {}];
    } else if (touch.view.tag == 2) {
        startLocation = [touch locationInView:touch.view];
        [UIView animateWithDuration:0.0f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^ {source2.center = CGPointMake(location.x, location.y);}
                         completion:^(BOOL complete) {}];
    } else {
        NSLog(@"Touched background");
    }
    
    //[self saveSelectedColor:location];
    
    //[_victoryLabel setText:@""];
    //[PaintGame colorPaintCans:_paintViewLarge :_paintRatioLarge];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    //if (CGRectContainsPoint([source1 frame], location)) {
    if (touch.view.tag == 1) {
        CGPoint pt = [touch locationInView:touch.view];
        CGRect frame = [source1 frame];
        frame.origin.x += pt.x - startLocation.x;
        frame.origin.y += pt.y - startLocation.y;
        [source1 setFrame:frame];
    } else if (touch.view.tag == 2) {
        CGPoint pt = [touch locationInView:touch.view];
        CGRect frame = [source2 frame];
        frame.origin.x += pt.x - startLocation.x;
        frame.origin.y += pt.y - startLocation.y;
        [source2 setFrame:frame];
        
    } else {
        NSLog(@"Touched background");
    }
}

// Calculates the location of touch up
// Input:  NSSet touches and UIEvent event
// Output: none
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:touch.view];
    
    //[self addColorToDestinationBucket:location];
}

// Save the color of the selected paint can if position within source can area
// Input:  CGPoint location of the touch
// Output: none
- (void)saveSelectedColor:(CGPoint) location
{
    // Checks the location of touch down and saves the appropriate source color if necessary
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:3];
    
    if (CGRectContainsPoint([source1 frame], location)) {
        array = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
    } /*else if (CGRectContainsPoint([source2 frame], location)) {
        array = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], nil];
    } else if (CGRectContainsPoint([source3 frame], location)) {
        array = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], nil];
    }*/ else {
        array = [self emptyRatioArray];
    }
    
    selectedColor = array;
    
}

// Adds the color of the selected paint to the ratio or otherwise resets selectedColor
// Input:  CGPoint location of the touch
// Output: none
- (void)addColorToDestinationBucket:(CGPoint) location
{
    // If the floats denoting the touch up location are within the area for the
    // paint bucket, then compute new destination ratio
    //if (CGRectContainsPoint([mixCan frame], location)) {
        
        /*for (int i = 0; i < 3; i++) {
            NSInteger value1 = [[mixCanRatio objectAtIndex:i] integerValue];
            NSInteger value2 = [[selectedColor objectAtIndex:i] integerValue];
            NSInteger sum = value1 + value2;
            NSNumber *sumNum = [NSNumber numberWithInteger: sum];
            [mixCanRatio replaceObjectAtIndex:i withObject:sumNum];
        }*/
        
        selectedColor = [self emptyRatioArray];
        
        // Otherwise reset the _selected color since it should no longer be selected
        // one touch up occurs
    /*} else {
        selectedColor = [self emptyRatioArray];
    }
    
    [mixCanLabel setText:[self ratioToString: mixCanRatio]];
    [self colorPaintCans:mixCan :mixCanRatio];*/
    
    [self checkWinCondition];
}

@end
