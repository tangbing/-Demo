//
//  CustomSearchBar.m
//  导航流行框架
//
//  Created by mac on 2017/7/4.
//  Copyright © 2017年 macTb. All rights reserved.
//

#import "CustomSearchBar.h"
#import "UIView+XMGExtension.h"

@implementation CustomSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:12];
        
        UIImage *image = [UIImage imageNamed:@"searchbar_textfield_background"];
        UIImage *stretchImage = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        self.background = stretchImage;
        
        [self setupLetView];
        [self setupRightView];
    }
    return self;
}

- (void)setupLetView
{
    self.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_search_bar_7_write"]];
     NSLog(@"%@",NSStringFromCGRect(self.leftView.frame));
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setupRightView
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"audio_nav_icon"] forState:UIControlStateNormal];
    rightBtn.size = rightBtn.currentImage.size;
    rightBtn.width += 17;
    rightBtn.contentMode = UIViewContentModeCenter;
   
    
    self.rightView = rightBtn;
     NSLog(@"%@",NSStringFromCGRect(self.rightView.frame));
    self.rightViewMode = UITextFieldViewModeAlways;
}

@end
