//
//  ThirdViewController.m
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//

#import "ThirdViewController.h"
#import "EditViewController.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController
{
    Task *task_d;
    NSMutableArray *low_done;
    NSMutableArray *medium_done;
    NSMutableArray *high_done;
}
static NSMutableArray *done;
static NSUserDefaults *def;

static NSDate *data;

+ (void)initialize{
    done = [NSMutableArray new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    def = [NSUserDefaults standardUserDefaults];
    [self.tableview reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    
    // self.state_done.selectedSegmentIndex = UISegmentedControlNoSegment;
    NSDate *done_data = [def objectForKey:@"Done"];
    done = [NSKeyedUnarchiver unarchiveObjectWithData: done_data];
    
    
    [self.tableview reloadData];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    low_done = [NSMutableArray new];
    medium_done = [NSMutableArray new];
    high_done = [NSMutableArray new];
    task_d = [Task new];
    for (int i = 0; i < done.count; i++){
        task_d = [done objectAtIndex:i];
        if([[[done objectAtIndex:i] t_priority] isEqualToString:@"Low"]){
            [low_done addObject:task_d];
        }
        else if ([[[done objectAtIndex:i] t_priority] isEqualToString:@"Medium"]){
            [medium_done addObject:task_d];
        }
        else if ([[[done objectAtIndex:i] t_priority] isEqualToString:@"High"]){
            [high_done addObject:task_d];
        }
    }
    
    [self.tableview reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_filter == TRUE){
        return 3;}
    else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numberOfRows = 0;
    if (_filter == TRUE){
        switch(section){
            case 0:
                numberOfRows = low_done.count;
                break;
            case 1:
                numberOfRows = medium_done.count;
                break;
            case 2:
                numberOfRows =high_done.count;
        }
        return numberOfRows;
    }
    else{
        return done.count;
    }
}
- (IBAction)filterdone:(id)sender {
    if (_filter == TRUE ){
        _filter = FALSE;
        
    }
    else{
        _filter = TRUE;
    }
    [self.tableview reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
    if (_filter == TRUE){
        switch (indexPath.section) {
            case 0:
                cell.textLabel.text = [[low_done objectAtIndex:indexPath.row] t_name];
                cell.imageView.image = [UIImage imageNamed:[[low_done objectAtIndex:indexPath.row] t_img]];
                cell.detailTextLabel.text = @"low";
                break;
            case 1:
                cell.textLabel.text = [[medium_done objectAtIndex:indexPath.row] t_name];
                cell.imageView.image = [UIImage imageNamed:[[medium_done objectAtIndex:indexPath.row] t_img]];
                cell.detailTextLabel.text = @"medium";
                break;
            case 2:
                cell.textLabel.text = [[high_done objectAtIndex:indexPath.row] t_name];
                cell.imageView.image = [UIImage imageNamed:[[high_done objectAtIndex:indexPath.row] t_img]];
                cell.detailTextLabel.text = @"high";
                break;
        }
    }else{
        cell.textLabel.text = [[done objectAtIndex:indexPath.row ] t_name];
        cell.imageView.image = [UIImage imageNamed:[[done objectAtIndex:indexPath.row ] t_img]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(done.count == 0){
        //_label.text = @"Add Tasks";
        
        _tableview.hidden = YES;
        return @"" ;
    }else{
        //_label.text = @"";
        _tableview.hidden = NO;
        
        NSString *str = @" ";
        if (_filter == TRUE){
            
            
            switch(section){
                case 0:
                    str = @"low";
                    break;
                case 1:
                    str = @"medium";
                    break;
                case 2:
                    str = @"high";
                    break;
            }}
        else{
            str = @" ";
        }
        return str;
    }
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Delete Task?" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableArray *new_done = [NSMutableArray new];
        
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            if(_filter == TRUE){
                switch(indexPath.section){
                    case 0:
                        [low_done removeObjectAtIndex:indexPath.row];
                        break;
                    case 1 :
                        [medium_done removeObjectAtIndex:indexPath.row];
                        break;
                    case 2:
                        [high_done removeObjectAtIndex:indexPath.row];
                        break;
                }
                
                
                done = new_done;
                [done addObjectsFromArray:low_done];
                [done addObjectsFromArray:medium_done];
                [done addObjectsFromArray:high_done];
                NSDate *date22 = [NSKeyedArchiver archivedDataWithRootObject:done];
                [def setObject:date22 forKey:@"Done"];
            }else{
                [done removeObjectAtIndex:indexPath.row];
                NSDate *date22 = [NSKeyedArchiver archivedDataWithRootObject:done];
                [def setObject:date22 forKey:@"Done"];
                
            }
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSDate *done_data = [def objectForKey:@"Done"];
            done = [NSKeyedUnarchiver unarchiveObjectWithData: done_data];
            
            low_done = [NSMutableArray new];
            medium_done = [NSMutableArray new];
            high_done = [NSMutableArray new];
            task_d = [Task new];
            for (int i = 0; i < done.count; i++){
                task_d = [done objectAtIndex:i];
                if([[[done objectAtIndex:i] t_priority] isEqualToString:@"Low"]){
                    [low_done addObject:task_d];
                }
                else if ([[[done objectAtIndex:i] t_priority] isEqualToString:@"Medium"]){
                    [medium_done addObject:task_d];
                }
                else if ([[[done objectAtIndex:i] t_priority] isEqualToString:@"High"]){
                    [high_done addObject:task_d];
                }
            }
            [self.tableview reloadData];
            
            
        } else if (editingStyle == UITableViewCellEditingStyleInsert) {
            
        }
        
        [self.tableview reloadData];
    }];
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:yes];
    [alert addAction:no];
    
    [self presentViewController:alert animated:YES completion:^{
        printf("alert done \n");
    }];
    [self.tableview reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditViewController *edit_done = [self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    edit_done.edit_task = [done objectAtIndex:indexPath.row];
    edit_done.index = indexPath.row;
    [self.navigationController pushViewController:edit_done animated:YES];
}

@end
