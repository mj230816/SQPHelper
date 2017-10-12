//
//  ImageFilters.m
//  ImageFilters
//
//  Created by 宋千 on 16/2/1.
//  Copyright © 2016年 宋千. All rights reserved.
//

#import "ImageFilters.h"

@interface ImageFilters ()

@property (nonatomic) CIContext *context;
@property (nonatomic) CIImage   *beginImage;

@end

@implementation ImageFilters

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _originalImage  = image;
        _context        = [CIContext contextWithOptions:nil];
        _beginImage     = [[CIImage alloc] initWithImage:_originalImage];
    }
    return self;
}

- (UIImage*)imageWithCIImage:(CIImage *)ciImage
{
    CGImageRef cgiImage = [self.context createCGImage:ciImage fromRect:ciImage.extent];
    UIImage *image = [UIImage imageWithCGImage:cgiImage];
    CGImageRelease(cgiImage);
    
    return image;
}

- (UIImage *)grayScaleImage
{
    if( !self.originalImage)
        return nil;
    
    CIImage *grayScaleFilter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, self.beginImage, @"inputBrightness", [NSNumber numberWithFloat:0.0], @"inputContrast", [NSNumber numberWithFloat:1.1], @"inputSaturation", [NSNumber numberWithFloat:0.0], nil].outputImage;
    
    CIImage *output = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues:kCIInputImageKey, grayScaleFilter, @"inputEV", [NSNumber numberWithFloat:0.7], nil].outputImage;
    
    UIImage *filteredImage = [self imageWithCIImage:output];
    return filteredImage;
}

- (UIImage *)oldImageWithIntensity:(CGFloat)intensity
{
    if( !self.originalImage )
        return nil;
    
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone"];
    [sepia setValue:self.beginImage forKey:kCIInputImageKey];
    [sepia setValue:@(intensity) forKey:@"inputIntensity"];
    
    CIFilter *random = [CIFilter filterWithName:@"CIRandomGenerator"];
    
    CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
    [lighten setValue:random.outputImage forKey:kCIInputImageKey];
    [lighten setValue:@(1 - intensity) forKey:@"inputBrightness"];
    [lighten setValue:@0.0 forKey:@"inputSaturation"];
    
    CIImage *croppedImage = [lighten.outputImage imageByCroppingToRect:[self.beginImage extent]];
    
    CIFilter *composite = [CIFilter filterWithName:@"CIHardLightBlendMode"];
    [composite setValue:sepia.outputImage forKey:kCIInputImageKey];
    [composite setValue:croppedImage forKey:kCIInputBackgroundImageKey];
    
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
    [vignette setValue:composite.outputImage forKey:kCIInputImageKey];
    [vignette setValue:@(intensity * 2) forKey:@"inputIntensity"];
    [vignette setValue:@(intensity * 30) forKey:@"inputRadius"];
    
    UIImage *filteredImage = [self imageWithCIImage:vignette.outputImage];
    
    return filteredImage;
}

@end
