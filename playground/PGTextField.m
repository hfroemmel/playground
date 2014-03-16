//
//  PGTextField.m
//  playground
//
//  Created by Hendrik Frömmel on 16.03.14.
//  Copyright (c) 2014 Hendrik Frömmel. All rights reserved.
//

#import "PGTextField.h"

@implementation PGTextField

- (void)awakeFromNib {
    self.layer.backgroundColor = [UIColor colorWithWhite:0 alpha:.05].CGColor;
    self.layer.cornerRadius = 5.f;
    
    [self setBorderStyle:UITextBorderStyleNone];
    [self setNeedsDisplay];
    
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithWhite:1 alpha:.33];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.attributedPlaceholder.string attributes:@{NSForegroundColorAttributeName: color}];
    }
}

@end
