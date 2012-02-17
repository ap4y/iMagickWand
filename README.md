iMagickWand
=============

UIImageView subclass which allows to change color of the image via tap gesture:

[![](https://github.com/ap4y/iMagickWand/blob/master/readme_img/before.png?raw=true)](https://github.com/ap4y/iMagickWand/blob/master/readme_img/before.png?raw=true)
[![](https://github.com/ap4y/iMagickWand/blob/master/readme_img/after.png?raw=true)](https://github.com/ap4y/iMagickWand/blob/master/readme_img/after.png?raw=true)

## Usage ##

    Same as regular UIImageView, just set:
        @property(nonatomic, retain) UIColor* color;
        @property(nonatomic) int tolerance;
    and it will be ready to receive your taps. Optionally implement MWImageViewDelegate and receive:
        -(void)imageViewDidStartedProcessing:(MWImageView*)imageView;
        -(void)imageViewDidFinishedProcessing:(MWImageView*)imageView;

Credits
-------

- [ImageMagick library](http://www.imagemagick.org/)
- [ImageMagick library for iOS](https://github.com/marforic/imagemagick_lib_iphone)

License
-------
Licensed under the Apache License, Version 2.0