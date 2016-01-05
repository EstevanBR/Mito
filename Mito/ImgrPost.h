//
//  ImgrPost.h
//  Mito
//
//  Created by Estevan Hernandez on 1/4/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ImgrPost : NSObject
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSURLSession *postSession;
@property (strong, nonatomic) NSURLSessionConfiguration *postSessionConfig;

-(id)initWithImageURL:(NSURL *)url;
+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width;

@end
