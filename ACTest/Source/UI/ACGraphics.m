//
// Created by Chris Hatton on 06/04/2013.
//

#import "ACGraphics.h"

CGRect ACRectMake( CGPoint point, CGSize size )
{
	return CGRectMake( point.x, point.y, size.width, size.height );
}

CGRect ACAliasRect( CGRect rect )
{
    return CGRectMake( roundf(rect.origin.x), roundf(rect.origin.y), roundf(rect.size.width), roundf(rect.size.height) );
}