//
//  TWPictureDataTransformer.m
//  Thousand Words
//
//  Created by yousheng chang on 8/22/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "TWPictureDataTransformer.h"

@implementation TWPictureDataTransformer

+(Class)transformedValueClass
{
    return [NSData class];
}

+(BOOL)allowsReverseTransformation
{
    return YES;
}

-(id)transformedValue:(id)value
{
    return UIImagePNGRepresentation(value); //return NSData object
}

-(id)reverseTransformedValue:(id)value
{
    UIImage *image = [UIImage imageWithData:value]; //return a image object
    return image;
}
@end
