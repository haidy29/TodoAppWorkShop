//
//  ViewController.m
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//

#import "ViewController.h"
#import "Task.h"
#import "AddViewController.h"
#import "EditViewController.h"




@interface ViewController ()

@end

@implementation ViewController{
    
}
static NSMutableArray *Filteredtasks;
static NSMutableArray *first_task;
static NSMutableArray *tasks;
static NSUserDefaults *def;

+ (void)initialize{
    first_task = [NSMutableArray new];
    tasks = [NSMutableArray new];
    def = [NSUserDefaults standardUserDefaults];
    Filteredtasks = [NSMutableArray new];

    if([def objectForKey:@"Task"] == nil){
        NSDate *data = [NSKeyedArchiver archivedDataWithRootObject:first_task];
        [def setObject:data forKey:@"Task"];
    }
}- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated{
    [ super viewDidAppear:true ];
    
}
    - (void)viewWillAppear:(BOOL)animated{
        NSDate *data2 = [def objectForKey:@"Task"];
        tasks = [NSKeyedUnarchiver unarchiveObjectWithData: data2];
        
        if(tasks.count == 0){
            _label.text = @"Add Tasks";
            
            _tableView.hidden = YES;
           
        }else{
            _label.text = @"";
            _tableView.hidden = NO;
            
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditViewController *Details = [self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    Details.edit_task = [tasks objectAtIndex:indexPath.row];
    Details.index = indexPath.row;
    [self.navigationController pushViewController:Details animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Delete Task?" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [tasks removeObjectAtIndex:indexPath.row];
            
            NSDate *date = [NSKeyedArchiver archivedDataWithRootObject:tasks];
            [def setObject:date forKey:@"Task"];
            // Delete the row from the data source
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        }
        [self.tableView reloadData];
    }];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:yes];
    [alert addAction:no];
    
    [self presentViewController:alert animated:YES completion:^{
        printf("alert done \n");
    }];
    [_tableView reloadData];
}
- (IBAction)btnadd:(id)sender {
    AddViewController *add = [self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    [self.navigationController pushViewController:add animated:YES];
}


@end
