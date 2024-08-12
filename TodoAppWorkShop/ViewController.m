//
//  ViewController.m
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//

#import "ViewController.h"
#import "Task.h"
#import "AddViewController.h"



@interface ViewController ()

@end

@implementation ViewController{
    
}

static NSMutableArray *first_task;
static NSMutableArray *tasks;
static NSUserDefaults *def;

+ (void)initialize{
    first_task = [NSMutableArray new];
    tasks = [NSMutableArray new];
    def = [NSUserDefaults standardUserDefaults];
    
    if([def objectForKey:@"Task"] == nil){
        NSDate *data = [NSKeyedArchiver archivedDataWithRootObject:first_task];
        [def setObject:data forKey:@"Task"];
    }
}- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *data2 = [def objectForKey:@"Task"];
    tasks = [NSKeyedUnarchiver unarchiveObjectWithData: data2];
    
    if(tasks.count == 0){
        _label.text = @"Add Tasks";
    }else{
        _label.text = @"";
    }
    [_tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if(tasks.count == 0){
//        _label.text = @"Add Tasks";
//    }
    cell.textLabel.text = [[tasks objectAtIndex:indexPath.row ] t_name];
    cell.imageView.image = [UIImage imageNamed:[[tasks objectAtIndex:indexPath.row ] t_img]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (IBAction)btnadd:(id)sender {
    AddViewController *add = [self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    [self.navigationController pushViewController:add animated:YES];
}

@end
