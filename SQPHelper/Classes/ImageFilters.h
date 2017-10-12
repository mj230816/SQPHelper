//
//  ImageFilters.h
//  ImageFilters
//
//  Created by 宋千 on 16/2/1.
//  Copyright © 2016年 宋千. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageFilters : NSObject

@property (nonatomic, readonly) UIImage *originalImage;

- (instancetype)initWithImage:(UIImage *)image;
- (UIImage *)grayScaleImage;
- (UIImage *)oldImageWithIntensity:(CGFloat)level;

@end
