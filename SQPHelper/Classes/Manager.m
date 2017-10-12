//
//  Manager.m
//  Pods-SQPHelper_Example
//
//  Created by 宋千 on 2017/10/12.
//

#import "Manager.h"
@import UIKit;

@implementation Manager

+ (NSBundle *)bundle {
    return [NSBundle bundleForClass:[self class]];
}

+ (id)vc {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    id avc = [[UIViewController alloc] initWithNibName:@"aaViewController"
                                       bundle:bundle];
    
    return avc;
}

@end
