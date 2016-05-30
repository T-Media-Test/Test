//
//  ZListBarScrollView.h
//  test
//
//  Created by joinus on 15/7/31.
//  Copyright (c) 2015年 joinus. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kStatusHeight 20
#define padding 20
#define itemPerLine 4
#define kItemW (kScreenW-padding*(itemPerLine+1))/itemPerLine
#define kItemH 25


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


@interface ZListBarScrollView : UIScrollView
@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, strong) UIView *btnBackView;
@property (nonatomic, strong) UIButton *btnSelect;
@property (nonatomic, strong) NSMutableArray *btnLists;


@property (nonatomic,copy) void(^listBarItemClickBlock)(NSString *itemName , NSInteger itemIndex);

@property (nonatomic,strong) NSMutableArray *visibleItemList;

-(void)itemClickByScrollerWithIndex:(NSInteger)index;

@end
