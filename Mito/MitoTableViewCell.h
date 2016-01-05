//
//  MitoTableViewCell.h
//  Mito
//
//  Created by Estevan Hernandez on 1/4/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImgrPost.h"

@interface MitoTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *mitoImageView;
@property (nonatomic, weak) ImgrPost *post;

@end
