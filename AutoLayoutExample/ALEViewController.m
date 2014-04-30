//
//  ALEViewController.m
//  AutoLayoutExample
//
//  Created by mito on 2014/04/23.
//  Copyright (c) 2014年 mito. All rights reserved.
//

#import "ALEViewController.h"
#import "Masonry.h"

@interface ALEViewController ()
@property (strong) UIView *view1;
@property (strong) UIView *view2;
@property (strong) UIView *view3;
@property (strong) UIButton *button;
@property (strong) MASConstraint *view3RightConstraint;
@property (assign) NSUInteger tapCount;
@end

@implementation ALEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view1 = [UIView new];
    self.view1.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:222 / 255.0 blue:147 / 255.0 alpha:1];
    [self.view addSubview:self.view1];
    self.view2 = [UIView new];
    self.view2.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:119 / 255.0 blue:96 / 255.0 alpha:1];
    [self.view addSubview:self.view2];
    self.view3 = [UIView new];
    self.view3.backgroundColor = [UIColor colorWithRed:80 / 255.0 green:55 / 255.0 blue:44 / 255.0 alpha:1];
    [self.view addSubview:self.view3];

    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(padding.top);
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-padding.bottom);
        make.right.equalTo(self.view2.mas_left).with.offset(-padding.right);
    }];
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(padding.top);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-padding.bottom);
        make.right.equalTo(self.view.mas_right).with.offset(-padding.right);
        make.width.equalTo(@(100));
    }];
    [self.view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-padding.bottom);
        self.view3RightConstraint = make.right.equalTo(self.view1.mas_right).with.offset(-padding.right);
        make.width.equalTo(@(50));
        make.height.equalTo(@(100));
    }];

    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"animate" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@(100));
        make.height.equalTo(@(50));
    }];
}

- (void)tap:(id)sender {
    self.tapCount++;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view3RightConstraint uninstall];
        [self.view3 mas_updateConstraints:^(MASConstraintMaker *make) {
            switch (self.tapCount % 3) {
                case 0:
                    make.width.equalTo(@50);
                    make.height.equalTo(@(100));
                    self.view3RightConstraint = make.right.equalTo(self.view1.mas_right).with.offset(-10);
                    break;
                case 1:
                    make.width.equalTo(@200);
                    self.view3RightConstraint = make.right.equalTo(self.view.mas_right).with.offset(-10);
                    break;
                case 2:
                    make.width.equalTo(@25);
                    make.height.equalTo(@(300));
                    self.view3RightConstraint = make.right.equalTo(self.view2.mas_right).with.offset(-10);
                    break;
                default:
                    break;
            }
            if (self.tapCount % 2 == 0) {
            } else {
            }
        }];
        [self.view layoutIfNeeded];
    }];
}

@end
