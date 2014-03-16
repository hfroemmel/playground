//
//  PGLoginViewController.m
//  playground
//
//  Created by Hendrik Frömmel on 14.03.14.
//  Copyright (c) 2014 Hendrik Frömmel. All rights reserved.
//

#import "PGLoginViewController.h"
#import "IIViewDeckController.h"

@interface PGLoginViewController () <IIViewDeckControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *helpButton;

@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton    *forgotPwdButton;

@end

@implementation PGLoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.viewDeckController.delegate = self;
    [self.userTextField becomeFirstResponder];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resignAllTextFieldResponders];
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController
           didOpenViewSide:(IIViewDeckSide)viewDeckSide
                  animated:(BOOL)animated
{
    [self resignAllTextFieldResponders];
}

-(void)viewDeckController:(IIViewDeckController *)viewDeckController
didShowCenterViewFromSide:(IIViewDeckSide)viewDeckSide
                 animated:(BOOL)animated
{
    self.viewDeckController.delegate = self;
    [self.userTextField becomeFirstResponder];
}

- (void)resignAllTextFieldResponders
{
    [self.userTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}

- (IBAction)didTouchMenuButton:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}
@end