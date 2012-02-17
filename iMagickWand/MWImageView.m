//
//  MWImageViewController.m
//  iMagickWand
//
//  Created by Arthur Evstifeev on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MWImageView.h"

#define ThrowWandException(wand) { \
char * description; \
ExceptionType severity; \
\
description = MagickGetException(wand,&severity); \
(void) fprintf(stderr, "%s %s %lu %s\n", GetMagickModule(), description); \
description = (char *) MagickRelinquishMemory(description); \
exit(-1); \
}

@implementation MWImageView
@synthesize color = _color, tolerance = _tolerance, mwDelegate = _mwDelegate;

- (void)dealloc {
    magick_wand = DestroyMagickWand(magick_wand);
	MagickWandTerminus();
}

- (void)processWithCoords {	
    
    float scaleWidth = self.image.size.width / self.frame.size.width;
    float scaleHeight = self.image.size.height / self.frame.size.height;
    
    float scale = scaleWidth > scaleHeight ? scaleWidth : scaleHeight;
    
	MagickWandGenesis();
    if (!magick_wand)
        magick_wand = NewMagickWand();
	
    NSData* dataObject = UIImagePNGRepresentation(self.image);
	
    MagickBooleanType status;
	status = MagickReadImageBlob(magick_wand, [dataObject bytes], [dataObject length]);
	if (status == MagickFalse) {
		ThrowWandException(magick_wand);
	}
	
	PixelWand *fc_wand = NULL;
	PixelWand *bc_wand = NULL;
	ChannelType channel;    
    
	fc_wand = NewPixelWand();
	bc_wand = NewPixelWand();
    
    if (!_color)
        @throw [NSException exceptionWithName:NSInternalInconsistencyException 
                                       reason:@"Please set fill color" 
                                     userInfo:nil];

    CGColorRef colorRef = [_color CGColor];
    const CGFloat *components = CGColorGetComponents(colorRef);
    
    NSString* colorString = [NSString stringWithFormat:@"rgb(%f,%f,%f)", components[0]*255.0f, 
                             components[1]*255.0f, components[2]*255.0f];
        
    if (!PixelSetColor(fc_wand, [colorString UTF8String]))
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Unable to set wand color" userInfo:nil];
    
    PixelIterator* iterator = NULL;
    PixelWand** pixels = NULL;
    size_t x;
    iterator = NewPixelRegionIterator(magick_wand, _touchCoords.x*scale, _touchCoords.y*scale, 1, 1);
	pixels = PixelGetNextIteratorRow(iterator,&x);
    bc_wand = pixels[0];
	
	channel = ParseChannelOption("rgba");
    
	//	The bordercolor=bc_wand (with fuzz of 20 applied) is replaced 
	// by the fill colour=fc_wand starting at the given coordinate - in this case 0,0.
	// Normally the last argument is MagickFalse so that the colours are matched but
	// if it is MagickTrue then it floodfills any pixel that does *not* match 
	// the target color
	status = MagickFloodfillPaintImage(magick_wand, channel, fc_wand, _tolerance, bc_wand, _touchCoords.x*scale, _touchCoords.y*scale, MagickFalse);
    if (status == MagickFalse) {
		ThrowWandException(magick_wand);
	}
	
	size_t my_size;
	unsigned char * my_image = MagickGetImageBlob(magick_wand, &my_size);
	NSData* data = [[NSData alloc] initWithBytes:my_image length:my_size];
	free(my_image);

	UIImage* image = [[UIImage alloc] initWithData:data];
	[data release];
	
	[self setImage:image];
	[image release];
    
    if(_mwDelegate)
        [_mwDelegate imageViewDidFinishedProcessing:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touches.count > 0) {
        UITouch* touch = [touches.allObjects objectAtIndex:0];
        _touchCoords = [touch locationInView:self];

        if(_mwDelegate)
            [_mwDelegate imageViewDidStartedProcessing:self];
        
        [self performSelectorInBackground:@selector(processWithCoords) withObject:nil];
    }
}

@end
