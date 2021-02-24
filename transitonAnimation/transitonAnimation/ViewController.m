//
//  ViewController.m
//  transitonAnimation
//
//  Created by chaostong on 2021/2/24.
//

#import "ViewController.h"
#import "PrefixHeader.pch"

#import "VC_Animation.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *describeArray;
@property (nonatomic, strong) NSArray *vcArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.title = @"转场动画";
    _dataSource = @[@"Push/Pop 转场"];
    _describeArray = @[@"左右侧滑转场效果"];
    _vcArray = @[[VC_Animation class]];
}

#pragma mark -- UITableViewDelegate  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    cell.imageView.image = [UIImage imageNamed:@"Chaos"];
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.detailTextLabel.text = _describeArray[indexPath.row];
    cell.detailTextLabel.numberOfLines = 2;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_vcArray[indexPath.row] == [VC_Animation class]) {
        VC_Animation *vcAnimation = [[_vcArray[indexPath.row] alloc] init];
//        在push动画之前设置动画代理
        self.navigationController.delegate = vcAnimation;
        [self.navigationController pushViewController:vcAnimation animated:YES];
    }
    
}

#pragma mark -- Getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
