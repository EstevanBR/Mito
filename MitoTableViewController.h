//
//  MitoTableViewController.h
//  Mito
//
//  Created by Estevan Hernandez on 1/4/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImgrPost.h"

@interface MitoTableViewController : UITableViewController
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURLSessionConfiguration *sessionConfig;
@property (strong, nonatomic) NSDictionary *feedDictionary;
@property (strong, nonatomic) NSArray *links;
@property (strong, nonatomic) NSArray *posts;

@end
