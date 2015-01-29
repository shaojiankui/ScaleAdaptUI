//
//  JKWindow.m
//  CustomWindow
//
//  Created by Jakey on 14/12/2.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "JKWindow.h"

@implementation JKWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self buildWindow];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self buildWindow];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}
#pragma mark - Private Methods
- (void)buildWindow
{
    // Ensure the version window is above the status bar.
    [self setWindowLevel:UIWindowLevelStatusBar + 1.0];
    // Ensure the version window is not hidden.
    [self setHidden:NO];
    // Disabe all user interaction with the version window.
    [self setUserInteractionEnabled:NO];
    // Enable autoresizing of the version window's subviews so the labels are correctly resized when the device's orientation changes.
    [self setAutoresizesSubviews:YES];
    // Reposition the window so it is above the status bar.
    [self rotationWithStatusBar];
    // Create a label to display the version number.
    UILabel *versionLabel = [[UILabel alloc] init];
    versionLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
    | UIViewAutoresizingFlexibleRightMargin;
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.textColor = [UIColor redColor];
    versionLabel.font = [UIFont boldSystemFontOfSize:10.0f];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.text =  [NSString stringWithFormat:@"Screen Size %@", NSStringFromCGSize([UIScreen mainScreen].bounds.size)];
    [versionLabel sizeToFit];
    versionLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-versionLabel.frame.size.width-30, 0, versionLabel.frame.size.width, self.bounds.size.height);
    [self addSubview: versionLabel];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(rotationWithStatusBar)
                                                 name:UIApplicationDidChangeStatusBarFrameNotification
                                               object:nil];
   
    self.rootViewController = nil;
    
}
- (void)rotationWithStatusBar
{
    UIApplication *sharedApplication = [UIApplication sharedApplication];
    // Rotate the version window so that it is the same orientation as the status bar.
    CGFloat angle = 0.0f;
    switch(sharedApplication.statusBarOrientation)
    {
        case UIInterfaceOrientationPortrait:
        {
            angle = 0.0f;
            break;
        }
        case UIInterfaceOrientationLandscapeLeft:
        {
            angle = -M_PI_2;
            break;
        }
        case UIInterfaceOrientationLandscapeRight:
        {
            angle = M_PI_2;
            break;
        }
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            angle = M_PI;
            break;
        }
    }
    self.transform = CGAffineTransformMakeRotation(angle);
    // Resize the version window so it will sit just above the status bar.
    self.frame = sharedApplication.statusBarFrame;
}
@end
