//
//  CommonCode.m
//  CommonCode
//
//  Created by 李力卓 on 14-1-15.
//  Copyright (c) 2014年 李力卓. All rights reserved.
//

#import "CommonCode.h"

@implementation CommonCode

+(UITextField*)makeTextFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)style font:(UIFont*)font adjusts:(BOOL)isAdjust minSize:(float)minSize clearMode:(UITextFieldViewMode)clearMode keyboardType:(UIKeyboardType)keyType autoCorrect:(UITextAutocorrectionType)autoCorrect autoCapital:(UITextAutocapitalizationType)autoCapital returnKey:(UIReturnKeyType)returnKey delegateTo:(id)className placeHolder:(NSString*)placeHolder
{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.borderStyle = style;
    textField.font = font;
    textField.adjustsFontSizeToFitWidth = isAdjust;
    textField.minimumFontSize = minSize;
    textField.clearButtonMode = clearMode;
    textField.keyboardType = keyType;
    textField.autocorrectionType = autoCorrect;
    textField.placeHolder = placeHolder;
    textField.autocapitalizationType = autoCapital;
    textField.returnKeyType = returnKey;
    textField.delegate = className;
    return [textField autorelease];
}

+(UIButton*)makeButtonWithFranme:(CGRect)frame imageName:(NSString*)imageName Title:(NSString*)title target:(id)target Action:(SEL)action type:(UIButtonType)btnType titleColor:(UIColor*)color
{
    UIButton*button=[UIButton buttonWithType:btnType];
    button.frame=frame;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // [button setBackgroundColor:[UIColor whiteColor]];
    return button;
}

+(UILabel*)makeLabelWithFrame:(CGRect)frame fone:(UIFont*)font Text:(NSString*)text numOfLine:(int)num textAligment:(NSTextAlignment)aligment backColor:(UIColor*)backColor textColor:(UIColor*)textColor
{
    UILabel*label=[[UILabel alloc]init];
    label.frame=frame;
    label.font=font;
    label.numberOfLines = num;
    label.textAlignment = aligment;
    label.text=text;
    label.textColor = textColor;
    label.backgroundColor =backColor;
    return [label autorelease];
    
}

+(UIView*)makeViewWithFrame:(CGRect)frame backColor:(UIColor*)color
{
    UIView*view=[[UIView alloc]init];
    view.frame=frame;
    view.backgroundColor = color;
    return [view autorelease];
}

+(UIImageView*)makeImageViewWithFrame:(CGRect)frame imageName:(NSString*)imageName backColor:(UIColor*)backColor
{
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:frame];
    imageview.image=[UIImage imageNamed:imageName];
    imageview.userInteractionEnabled=YES;
    imageview.backgroundColor = backColor;
    return [imageview autorelease] ;
}

+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size isPage:(BOOL)isPage horizonIndicator:(BOOL)horizon verticalIndicator:(BOOL)vertical backColor:(UIColor*)backColor
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    scrollView.pagingEnabled = isPage;
    scrollView.contentSize = size;
    scrollView.showsHorizontalScrollIndicator = horizon;
    scrollView.showsVerticalScrollIndicator = vertical;
    scrollView.scrollsToTop = NO;
    scrollView.backgroundColor = backColor;
    return [scrollView autorelease];
}

+(UIPageControl*)makePageControlWithFrame:(CGRect)frame numOfPage:(int)num currentPage:(int)currentPage
{
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:frame];
    pageControl.numberOfPages = num;
    pageControl.currentPage = currentPage;
    return [pageControl autorelease];
}

+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image
{
    UISlider *slider = [[UISlider alloc]initWithFrame:rect];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    [slider setThumbImage:[UIImage imageNamed:@"qiu"] forState:UIControlStateNormal];
    slider.maximumTrackTintColor = [UIColor grayColor];
    slider.minimumTrackTintColor = [UIColor yellowColor];
    slider.continuous = YES;
    slider.enabled = YES;
    return [slider autorelease];
}

+(UITableView*)maketableWithFrame:(CGRect)rect tableStyle:(UITableViewStyle)tableStyle separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle delegateTo:(id)className backColor:(UIColor*)backColor
{
    UITableView *table = [[UITableView alloc] initWithFrame:rect style:tableStyle];
    table.separatorStyle = separatorStyle;
    table.delegate = className;
    table.dataSource = className;
    table.backgroundColor = backColor;
    return [table autorelease];
}

@end
