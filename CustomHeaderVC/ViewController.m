//
//  ViewController.m
//  CustomHeaderVC
//
//  Created by 何华均 on 2016/10/25.
//  Copyright © 2016年 hhj. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tb;
@property(nonatomic,strong)HeaderView *header;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义表头";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tb = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tb.delegate =self;
    self.tb.dataSource =self;
    [self.tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tb];
    
    self.header = [HeaderView headerView];
    self.tb.tableHeaderView = self.header;
}

#pragma mark- table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"text";
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
