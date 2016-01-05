//
//  MitoTableViewController.m
//  Mito
//
//  Created by Estevan Hernandez on 1/4/16.
//  Copyright © 2016 Estevan Hernandez (Monolith). All rights reserved.
//

#import "MitoTableViewController.h"
#import "MitoTableViewCell.h"

@interface MitoTableViewController ()
@end

@implementation MitoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(requestSuccessful)
                                                 name:@"feedDownloaded"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(imageDownloaded)
                                                 name:@"imageDownloaded"
                                               object:nil];
    [self getFeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return (320.0 * (16/9));
    ImgrPost *post = self.posts[indexPath.row];
    return post.image.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return 1;
    return [self.posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MitoTableViewCell *cell = (MitoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"feedCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MitoCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.post = self.posts[indexPath.row];
    [cell.mitoImageView setImage:cell.post.image];
    //[cell.mitoImageView setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.mitoImageView.frame.size.width, cell.mitoImageView.frame.size.height)];
    [cell.mitoImageView setFrame:CGRectMake(0, 0, cell.mitoImageView.frame.size.width, cell.mitoImageView.frame.size.height)];
    NSLog(@"\ncell Y: %f\n"
           "img  Y: %f", cell.frame.origin.y, cell.mitoImageView.frame.origin.y);
    cell.backgroundColor = [UIColor colorWithHue:1.0/[self.posts count]*indexPath.row saturation:0.5 brightness:0.25 alpha:1.0];
    return cell;
}

-(void)requestSuccessful {
    NSMutableArray *mutableLinks = [[NSMutableArray alloc] init];
    NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];
    for (NSDictionary *link in self.feedDictionary[@"data"]) {
        if ([link[@"type"] isEqualToString:@"image/jpeg"] || [link[@"type"] isEqualToString:@"image/png"]) {
            [mutableLinks addObject:link[@"link"]];
            [mutablePosts addObject:[[ImgrPost alloc] initWithImageURL:[NSURL URLWithString:link[@"link"]]]];
        }
    }
    self.links = (NSArray *) mutableLinks;
    self.posts = (NSArray *) mutablePosts;
}

-(void)imageDownloaded {
    [self.tableView reloadData];
}

-(void)getFeed {
    NSString *imgurFeed = [NSString stringWithFormat:@"https://api.imgur.com/3/gallery/r/%@/time/1", @"cats"];
    self.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [[NSURLSession alloc] init];
    [self.sessionConfig setHTTPAdditionalHeaders:@{@"Authorization":@"Client-ID 98a520b626069bb"}];
    self.session = [NSURLSession sessionWithConfiguration:self.sessionConfig
                                                 delegate:nil
                                            delegateQueue:nil];
    
    [[self.session dataTaskWithURL:[NSURL URLWithString:imgurFeed]
                 completionHandler:^(NSData *data,
                                     NSURLResponse *response,
                                     NSError *connectionError) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         self.feedDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                         NSLog(@"%@", self.feedDictionary);
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"feedDownloaded"
                                                                             object:nil];
                     });
                     
                 }] resume];
}

@end
