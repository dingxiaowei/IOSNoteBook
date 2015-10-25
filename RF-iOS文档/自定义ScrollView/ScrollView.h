//
//  ScrollView.h
//  IXM
//
//  Created by qianfeng on 14-7-17.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollView : UIView<UIScrollViewDelegate>
@property(nonatomic,retain)NSMutableArray * imageNameArr;
@property(nonatomic,retain)UIScrollView * scroll;

- (id)initWithFrame:(CGRect)frame andImageNameArr:(NSArray *)imageNameArr;
@end
