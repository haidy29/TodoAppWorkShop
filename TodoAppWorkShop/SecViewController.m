//
//  SecViewController.m
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//

#import "SecViewController.h"
#import "EditViewController.h"
@interface SecViewController ()

@end

@implementation SecViewController
{
    Task *task_p;
    NSMutableArray *low_pro;
    NSMutableArray *medium_pro;
    NSMutableArray *high_pro;
}

static NSMutableArray *progress;
static NSUserDefaults *def;

+ (void)initialize{
    progress = [NSMutableArray new];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    def = [NSUserDefaults standardUserDefaults];
    
            
    [_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    self.prograsspri.selectedSegmentIndex = UISegmentedControlNoSegment;
    
    NSDate *progress_data = [def objectForKey:@"InProgress"];
    progress = [NSKeyedUnarchiver unarchiveObjectWithData: progress_data];

    [_tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    
    low_pro = [NSMutableArray new];
    medium_pro = [NSMutableArray new];
    high_pro = [NSMutableArray new];
    task_p = [Task new];
    for (int i = 0; i < progress.count; i++){
        task_p = [progress objectAtIndex:i];
        if([[[progress objectAtIndex:i] t_priority] isEqualToString:@"Low"]){
            [low_pro addObject:task_p];
        }
        else if ([[[progress objectAtIndex:i] t_priority] isEqualToString:@"Medium"]){
            [medium_pro addObject:task_p];
        }
        else if ([[[progress objectAtIndex:i] t_priority] isEqualToString:@"High"]){
            [high_pro addObject:task_p];
        }
    }
    [_tableView reloadData];
}

- (IBAction)progressAction:(id)sender {
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numberOfRows = 0;
    if(self.prograsspri.selectedSegmentIndex == 0){
        switch(section){
            case 0: //low
                numberOfRows = low_pro.count;
                break;
            case 1: // medium
                numberOfRows = 0;
                break;
            case 2: //high
                numberOfRows = 0;
        }
    }else if (self.prograsspri.selectedSegmentIndex == 1){
        switch(section){
            case 0: //low
                numberOfRows = 0;
                break;
            case 1: // medium
                numberOfRows = medium_pro.count;
                break;
            case 2: //high
                numberOfRows = 0;
        }
    }else if (self.prograsspri.selectedSegmentIndex == 2){
        switch(section){
            case 0: //low
                numberOfRows = 0;
                break;
            case 1: // medium
                numberOfRows = 0;
                break;
            case 2: //high
                numberOfRows = high_pro.count;
        }
    }else{
        switch(section){
            case 0: //low
                numberOfRows = low_pro.count;
                break;
            case 1: // medium
                numberOfRows = medium_pro.count;
                break;
            case 2: //high
                numberOfRows = high_pro.count;
        }
    }
    return numberOfRows;
//    return progress.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [[low_pro objectAtIndex:indexPath.row] t_name];
            cell.imageView.image = [UIImage imageNamed:[[low_pro objectAtIndex:indexPath.row] t_img]];
            cell.detailTextLabel.text = @"low";
            break;
        case 1:
            cell.textLabel.text = [[medium_pro objectAtIndex:indexPath.row] t_name];
            cell.imageView.image = [UIImage imageNamed:[[medium_pro objectAtIndex:indexPath.row] t_img]];
            cell.detailTextLabel.text = @"medium";
            break;
        case 2:
            cell.textLabel.text = [[high_pro objectAtIndex:indexPath.row] t_name];
            cell.imageView.image = [UIImage imageNamed:[[high_pro objectAtIndex:indexPath.row] t_img]];
            cell.detailTextLabel.text = @"high";
            break;
    }
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 40;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str = @"";
    switch(section){
        case 0: //low
            str = @"low";
            break;
        case 1: //medium
            str = @"medium";
            break;
        case 2: //high
            str = @"high";
            break;
    }
    return str;
}

 

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Delete Task?" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

            NSMutableArray *new_pro = [NSMutableArray new];
            
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                switch(indexPath.section){
                    case 0:
                        [low_pro removeObjectAtIndex:indexPath.row];
                        break;
                    case 1 :
                        [medium_pro removeObjectAtIndex:indexPath.row];
                        break;
                    case 2:
                        [high_pro removeObjectAtIndex:indexPath.row];
                        break;
                }
                progress = new_pro;
                [progress addObjectsFromArray:low_pro];
                [progress addObjectsFromArray:medium_pro];
                [progress addObjectsFromArray:high_pro];
                NSDate *date22 = [NSKeyedArchiver archivedDataWithRootObject:progress];
                [def setObject:date22 forKey:@"InProgress"];
                
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                [_tableView reloadData];
                
            
            } else if (editingStyle == UITableViewCellEditingStyleInsert) {
                
            }

            [_tableView reloadData];
    }];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }]; //normal
    
    [alert addAction:yes];
    [alert addAction:no];
    
    [self presentViewController:alert animated:YES completion:^{
        printf("alert done \n");
    }];
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditViewController *edit_pro = [self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];

    edit_pro.edit_task = [progress objectAtIndex:indexPath.row];
    edit_pro.index = indexPath.row;
    [self.navigationController pushViewController:edit_pro animated:YES];
}

@end
