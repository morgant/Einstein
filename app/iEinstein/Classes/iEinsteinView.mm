//
//  iEinsteinViewController.m
//  iEinstein
//
//  Created by Matthias Melcher on 12.09.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "iEinsteinView.h"
#import "TIOSScreenManager.h"

@implementation iEinsteinView

#if !(defined kCGBitmapByteOrder32Host) && TARGET_RT_BIG_ENDIAN
#define kAlphaNoneSkipFirstPlusHostByteOrder (kCGImageAlphaNoneSkipFirst)
#else
#define kAlphaNoneSkipFirstPlusHostByteOrder (kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Host)
#endif


- (id)init {
  mScreenManager = 0L;
  mWidth = 320;
  mHeight = 480;
  return self;
}


- (void)dealloc {
  [super dealloc];
}

- (void)SetScreenManager:(id)sm 
{ 
  mScreenManager = sm; 
} 



- (void)drawRect:(CGRect)rect {
  mWidth = 320;
  mHeight = 480;
  /*
  CGContextRef context = UIGraphicsGetCurrentContext(); 
  CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0); // yellow line
  
  CGContextBeginPath(context);
  
  CGContextMoveToPoint(context, 50.0, 50.0); //start point
  CGContextAddLineToPoint(context, 250.0, 100.0);
  CGContextAddLineToPoint(context, 250.0, 350.0);
  CGContextAddLineToPoint(context, 50.0, 350.0); // end path
  
  CGContextClosePath(context); // close path
  
  CGContextSetLineWidth(context, 8.0); // this is set from now on until you explicitly change it
  
  CGContextStrokePath(context); // do actual stroking
  
  CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5); // green color, half transparent
  CGContextFillRect(context, CGRectMake(20.0, 250.0, 128.0, 128.0)); // a square at the bottom left-hand corner
  */
  // setNeedsDisplay
  if (mScreenManager != NULL)
  {
    CGContextRef theContext = UIGraphicsGetCurrentContext(); 
    if(mScreenImage == NULL)
    {
      CGColorSpaceRef theColorSpace = CGColorSpaceCreateDeviceRGB();
      mScreenImage = CGImageCreate(
                                   mWidth,
                                   mHeight,
                                   8,
                                   32,
                                   mWidth * sizeof(KUInt32),
                                   theColorSpace,
                                   kAlphaNoneSkipFirstPlusHostByteOrder,
                                   ((TIOSScreenManager*)mScreenManager)->GetDataProvider(),
                                   NULL,
                                   false,
                                   kCGRenderingIntentAbsoluteColorimetric );
      CGColorSpaceRelease(theColorSpace);
    }
    /*
    switch (mOrientation)
    {
      case kNormal:
        break;
        
      case k90Clockwise:
        CGContextTranslateCTM(theContext, 0, mWidth);
        CGContextRotateCTM(theContext, -M_PI/2.0);
        break;
        
      case k180Clockwise:
        CGContextTranslateCTM(theContext, mWidth, mHeight);
        CGContextRotateCTM(theContext, M_PI);
        break;
        
      case k270Clockwise:
        CGContextTranslateCTM(theContext, mHeight, 0);
        CGContextRotateCTM(theContext, M_PI/2.0);
        break;
    }
    */
    CGContextDrawImage(theContext,
                       CGRectMake(
                                  0.0,
                                  0.0,
                                  mWidth,
                                  mHeight),
                       mScreenImage);
  }
}


@end
