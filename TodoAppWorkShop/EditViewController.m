//
//  EditViewController.m
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController
{
    
}
static NSMutableArray *todo_tasks;
static NSMutableArray *inProgress_tasks;
static NSMutableArray *done_tasks;
static NSUserDefaults *def;


+ (void)initialize{
    todo_tasks = [NSMutableArray new];
    inProgress_tasks = [NSMutableArray new];
    done_tasks = [NSMutableArray new];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // present the data which is passed
    _lbltitle.text =  _edit_task.t_name;
    _lbldes.text = _edit_task.t_des;
    _datePicker.date = _edit_task.t_date;
    if([_edit_task.t_priority  isEqualToString: @"Low"]){
        self.prioritysegment.selectedSegmentIndex = 0;
    }else if([_edit_task.t_priority  isEqual: @"Medium"]){
        self.prioritysegment.selectedSegmentIndex = 1;
    }else if([_edit_task.t_priority  isEqual: @"High"]){
        self.prioritysegment.selectedSegmentIndex = 2;
    }
    
    def = [NSUserDefaults standardUserDefaults];
    NSDate *data2 = [def objectForKey:@"Task"];
    todo_tasks = [NSKeyedUnarchiver unarchiveObjectWithData: data2];
}
- (IBAction)btnedit:(id)sender {
    if((_lbltitle.text.length > 0) && !([_lbldes.text isEqualToString:@""])){
        Task *t = [Task new];
        //put the edit data in new object
        t.t_name = _lbltitle.text;
        t.t_des = _lbldes.text;
        t.t_date =_datePicker.date;
        if(self.prioritysegment.selectedSegmentIndex == 0){
            t.t_img = @"low";
            t.t_priority = @"Low";
        }else if (self.prioritysegment.selectedSegmentIndex == 1){
            t.t_img = @"medium";
            t.t_priority = @"Medium";
        }else if(self.prioritysegment.selectedSegmentIndex == 2){
            t.t_img = @"3";
            t.t_priority = @"high2";
            
        }
        if(self.Typesegment.selectedSegmentIndex == 0){
            t.t_state = @"Todo";
        }else if (self.Typesegment.selectedSegmentIndex == 1){
            t.t_state = @"InProgress";
        }else if(self.Typesegment.selectedSegmentIndex == 2){
            t.t_state = @"Done";
        }
        if([t.t_state isEqualToString:@"Todo"]){
            
            [todo_tasks replaceObjectAtIndex:_index withObject:t];
            NSDate *data = [NSKeyedArchiver archivedDataWithRootObject:todo_tasks];
            [def setObject:data forKey:@"Task"];
            
        }
        else if([t.t_state isEqualToString:@"InProgress"]){
            [todo_tasks removeObjectAtIndex:_index];
            NSDate *data1 = [NSKeyedArchiver archivedDataWithRootObject:todo_tasks];
            [def setObject:data1 forKey:@"Task"];
            if([def objectForKey:@"InProgress"] == nil){
                //if inprogress empty archive
                [inProgress_tasks addObject:t];
                NSDate *data = [NSKeyedArchiver archivedDataWithRootObject:inProgress_tasks];
                [def setObject:data forKey:@"InProgress"];
            }
            else if ([def objectForKey:@"InProgress"] != nil){
                NSData *data4 = [def objectForKey:@"InProgress"];
                inProgress_tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data4];
                
                [inProgress_tasks addObject:t];
                NSDate *data = [NSKeyedArchiver archivedDataWithRootObject:inProgress_tasks];
                [def setObject:data forKey:@"InProgress"];
            }
            
        }
        else if([t.t_state isEqualToString:@"Done"]){
            [todo_tasks removeObjectAtIndex:_index];
            NSDate *date1 = [NSKeyedArchiver archivedDataWithRootObject:todo_tasks];
            [def setObject:date1 forKey:@"Task"];
            NSUserDefaults *defa = [NSUserDefaults standardUserDefaults];
            
            if([def objectForKey:@"Done"] == nil){
                [done_tasks addObject:t];
                NSDate *data3 = [NSKeyedArchiver archivedDataWithRootObject:done_tasks];
                [defa setObject:data3 forKey:@"Done"];
            }else if([def objectForKey:@"Done"] != nil){
                NSData *data4 = [defa objectForKey:@"Done"];
                done_tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data4];
                
                [done_tasks addObject:t];
                NSDate *data_done = [NSKeyedArchiver archivedDataWithRootObject:done_tasks];
                [defa setObject:data_done forKey:@"Done"];
            }
            
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        UIAlertController *empty_alert = [UIAlertController alertControllerWithTitle:@"Empty Task" message:@"Please Add the Title And Description" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [empty_alert addAction: ok];
        [self presentViewController:empty_alert animated:YES completion:nil];
    }
}

@end
