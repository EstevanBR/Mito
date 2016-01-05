//
//  ImgrPost.m
//  Mito
//
//  Created by Estevan Hernandez on 1/4/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import "ImgrPost.h"

@implementation ImgrPost
-(id)initWithImageURL:(NSURL *) url {
    self = [super init];
    self.imageURL = url;
    self.image = [UIImage imageNamed:@"MonolithBlank"];
    self.postSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    [self.postSessionConfig setHTTPAdditionalHeaders:@{@"Authorization":@"Client-ID 98a520b626069bb"}];
    //[self.postSessionConfig setHTTPAdditionalHeaders:@{@"Accept-Content-Type":@"image/jpeg"}];
    self.postSession = [NSURLSession sessionWithConfiguration:self.postSessionConfig
                                                     delegate:nil
                                                delegateQueue:nil];
    [self getImageForPost];
    return self;

}

-(void)getImageForPost {
    [[self.postSession dataTaskWithURL:self.imageURL
                 completionHandler:^(NSData *data,
                                     NSURLResponse *response,
                                     NSError *connectionError) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         self.image = [ImgrPost imageWithImage:[UIImage imageWithData:data] scaledToWidth:320];
                         NSLog(@"getImageForPost Success!!\n🍌image is #%@# from %@, or error %@", self.image, response, connectionError);
                         //NSLog(@"getImageForPost Success!!\n🍌image is #%@#", self.image);
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"imageDownloaded"
                                                                             object:nil];
                     });
                 }] resume];
}

+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
