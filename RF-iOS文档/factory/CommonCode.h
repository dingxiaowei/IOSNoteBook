//
//  CommonCode.h
//  CommonCode
//
//  Created by 李力卓 on 14-1-15.
//  Copyright (c) 2014年 李力卓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonCode : NSObject

+(UIButton*)makeButtonWithFranme:(CGRect)frame imageName:(NSString*)imageName Title:(NSString*)title target:(id)target Action:(SEL)action type:(UIButtonType)btnType titleColor:(UIColor*)color;

+(UILabel*)makeLabelWithFrame:(CGRect)frame fone:(UIFont*)font Text:(NSString*)text numOfLine:(int)num textAligment:(NSTextAlignment)aligment backColor:(UIColor*)backColor textColor:(UIColor*)textColor;

+(UIView*)makeViewWithFrame:(CGRect)frame backColor:(UIColor*)color;

+(UIImageView*)makeImageViewWithFrame:(CGRect)frame imageName:(NSString*)imageName backColor:(UIColor*)backColor;

+(UITextField*)makeTextFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)style font:(UIFont*)font adjusts:(BOOL)isAdjust minSize:(float)minSize clearMode:(UITextFieldViewMode)clearMode keyboardType:(UIKeyboardType)keyType autoCorrect:(UITextAutocorrectionType)autoCorrect autoCapital:(UITextAutocapitalizationType)autoCapital returnKey:(UIReturnKeyType)returnKey delegateTo:(id)className placeHolder:(NSString*)placeHolder;

+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size isPage:(BOOL)isPage horizonIndicator:(BOOL)horizon verticalIndicator:(BOOL)vertical backColor:(UIColor*)backColor;

+(UIPageControl*)makePageControlWithFrame:(CGRect)frame numOfPage:(int)num currentPage:(int)currentPage;

+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image;

+(UITableView*)maketableWithFrame:(CGRect)rect tableStyle:(UITableViewStyle)tableStyle separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle delegateTo:(id)className backColor:(UIColor*)backColor;
@end
