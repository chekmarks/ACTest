//
// Created by Chris Hatton on 07/04/2013.
//
#import "UIImage+Blank.h"

@implementation UIImage (Blank)

+ (UIImage*)blankImage:(CGSize)size withColor:(UIColor*)color
{
	UIGraphicsBeginImageContext(size);

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor( context, color.CGColor );
	CGContextFillRect( context, CGRectMake(0.0, 0.0, size.width, size.height) );

    __strong UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

	UIGraphicsEndImageContext();

	return image;
}

@end