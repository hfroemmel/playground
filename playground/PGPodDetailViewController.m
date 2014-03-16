//
//  PGPodDetailViewController.m
//  playground
//
//  Created by Hendrik Frömmel on 14.03.14.
//  Copyright (c) 2014 Hendrik Frömmel. All rights reserved.
//

#import "PGPodDetailViewController.h"

@interface PGPodDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation PGPodDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.titleLabel.text = self.pod.name;
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.backgroundColor = [UIColor whiteColor].CGColor;
}

@end
