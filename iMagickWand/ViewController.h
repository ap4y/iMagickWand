//
//  ViewController.h
//  iMagickWand
//
//  Created by Arthur Evstifeev on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWImageView.h"

@interface ViewController : UIViewController <MWImageViewDelegate> {
    
    IBOutlet UIActivityIndicatorView *_spinner;
    IBOutlet MWImageView *imageView;
}

@end
