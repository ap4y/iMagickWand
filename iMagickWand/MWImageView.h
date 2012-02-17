//
//  MWImageViewController.h
//  iMagickWand
//
//  Created by Arthur Evstifeev on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MagickWand.h"

@protocol MWImageViewDelegate;
@interface MWImageView : UIImageView {
    MagickWand * magick_wand;
    UIColor* _color;
    int _tolerance;
    
    CGPoint _touchCoords;
    id<MWImageViewDelegate> _mwDelegate;
}

@property(nonatomic, retain) UIColor* color;
@property(nonatomic) int tolerance;
@property(nonatomic, retain) id<MWImageViewDelegate> mwDelegate;

@end

@protocol MWImageViewDelegate
@optional

-(void)imageViewDidStartedProcessing:(MWImageView*)imageView;
-(void)imageViewDidFinishedProcessing:(MWImageView*)imageView;

@end
