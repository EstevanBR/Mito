//
//  MitoTableViewCell.m
//  Mito
//
//  Created by Estevan Hernandez on 1/4/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import "MitoTableViewCell.h"
#import "ImgrPost.h"

@implementation MitoTableViewCell
@synthesize mitoImageView = _mitoImageView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
