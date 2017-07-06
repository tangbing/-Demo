//
//  ViewController.m
//  导航流行框架
//
//  Created by mac on 17/3/6.
//  Copyright © 2017年 macTb. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"
#import "ATCustomHeader.h"
#import "MJRefresh.h"
#import "SDCycleScrollView.h"
#import "UIBarButtonItem+XMGExtension.h"
#import "CustomSearchBar.h"
#import "UIView+XMGExtension.h"
#import "Masonry.h"


#define XMGRGBColor(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
/**
 * 随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *customTableView;
@property (weak, nonatomic) IBOutlet UIView *customNav;
@property (nonatomic, strong)UIImageView *barImageView;

@property (nonatomic, strong)CustomSearchBar *searchBar;

@property (nonatomic, strong)UIButton *leftBtnScan;

@property (nonatomic, strong)UIButton *rightBtnVoice;

/** 用来显示的假数据 */
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation ViewController

static const CGFloat navBarButtonY = 44 * 0.5 + 20;

static const CGFloat SDCycleScrollViewH = 180;


- (CustomSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[CustomSearchBar alloc] init];
        _searchBar.width = [UIScreen mainScreen].bounds.size.width * 0.7 ;
        _searchBar.height = 30;
        _searchBar.centerX = [UIScreen mainScreen].bounds.size.width * 0.5;
        _searchBar.centerY = navBarButtonY;
    }
    return _searchBar;
}

- (UIButton *)leftBtnScan
{
    if (!_leftBtnScan) {
        _leftBtnScan = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtnScan setImage:[UIImage imageNamed:@"find_icon_sao"] forState:UIControlStateNormal];
        _leftBtnScan.size = _leftBtnScan.currentImage.size;
        _leftBtnScan.centerX = [UIScreen mainScreen].bounds.size.width * 0.3 * 0.5 * 0.5;
        _leftBtnScan.centerY = navBarButtonY;
        [_leftBtnScan addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtnScan;
}

- (UIButton *)rightBtnVoice
{
    if (!_rightBtnVoice) {
        _rightBtnVoice = [[UIButton alloc] init];
        [_rightBtnVoice setImage:[UIImage imageNamed:@"my_message_btn_h"] forState:UIControlStateNormal];
        _rightBtnVoice.size = _leftBtnScan.currentImage.size;
        _rightBtnVoice.centerX = [UIScreen mainScreen].bounds.size.width * 0.3 * 0.5 * (1 + 0.5) + [UIScreen mainScreen].bounds.size.width * 0.7;
        _rightBtnVoice.centerY = navBarButtonY;
        [_rightBtnVoice addTarget:self action:@selector(voice) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtnVoice;
}

- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            [self.data addObject:MJRandomData];
        }
    }
    return _data;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.customNav addSubview:self.searchBar];
    [self.customNav addSubview:self.leftBtnScan];
    [self.customNav addSubview:self.rightBtnVoice];
    
    self.searchBar.superview.backgroundColor = XMGRGBColor(33, 192, 174, 0.01);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self stupHeader];
    [self setupHeaderTableView];
}

- (void)scan
{
    
}
- (void)voice
{
    
}
- (void)setupHeaderTableView
{
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    CGFloat w = self.view.bounds.size.width;
    
    
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, SDCycleScrollViewH) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.currentPageDotColor = [UIColor blueColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    self.customTableView.tableHeaderView = cycleScrollView2;
    
}

- (void)stupHeader
{
    ATCustomHeader *header = [ATCustomHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.customTableView.mj_header = header;
    
}

- (void)loadNewData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data insertObject:MJRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.customTableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
        
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"tab";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat BaseAlpha = 0.01;
    CGFloat offset = scrollView.contentOffset.y;
    NSLog(@"%f",offset);
    
    if (offset > 0.0) {// 向上拖动，
        // 0.1 ---> 1.0.滑动64个单位，alpha从0.1---->1.0
        if (offset <= SDCycleScrollViewH - 64) {
            BaseAlpha = offset / (SDCycleScrollViewH - 64);
        } else {
            BaseAlpha = 1.0;
        }

    } else if(offset <0.0) {// 向下拖动，
        self.customNav.hidden = YES;
    } else {
        self.customNav.hidden = NO;
        BaseAlpha = 0.01;

    }
    self.searchBar.superview.backgroundColor = XMGRGBColor(33, 192, 174, BaseAlpha);
}


@end
