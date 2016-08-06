//
//  RoundImageView.m
//  iOSTest
//
//  Created by lzz on 13-11-19.
//  Copyright (c) 2013年 sowin. All rights reserved.
//

#import "RoundImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation RoundImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imageOffset = 1;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void) setImage:(UIImage *)image
{
    if (_image!=image)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _image = image;
        
        [self setNeedsDisplay];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    //get current graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //save old context
    CGContextSaveGState(context);
    
    //get the border(rect) of circle
    CGRect clipRect = CGRectMake(imageOffset, imageOffset, self.frame.size.width-(imageOffset*2), self.frame.size.height-(imageOffset*2));
    
    //add ellipse path to context
    CGContextAddEllipseInRect(context, clipRect);
    
    //modify the clip path
    CGContextClip(context);
    
    //create a rectangle that we will paint image on it
    CGContextClearRect(context, clipRect);
    
    //use our make path to draw we want to get shape(image)
    [self.image drawInRect:CGRectMake(clipRect.origin.x, clipRect.origin.y, clipRect.size.width, clipRect.size.height)];
    
    //recover context
    CGContextRestoreGState(context);
}


@end
