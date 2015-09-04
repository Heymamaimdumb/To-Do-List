//
//  MainTargetVC.m
//  ToDo List
//
//  Created by Vladislav on 02.09.15.
//  Copyright (c) 2015 Vladislav. All rights reserved.
//

#import "MainTargetVC.h"
#import "EditDateVC.h"
@interface MainTargetVC ()

@property (nonatomic,strong) NSMutableArray *arrayEvents;

@end

@implementation MainTargetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    self.arrayEvents = [[NSMutableArray alloc]initWithArray:array];
    
    
}
#pragma mark - Table view data source

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditDateVC *editDate = [self.storyboard instantiateViewControllerWithIdentifier:@"editDate"];
   
    UILocalNotification *notification = [self.arrayEvents objectAtIndex:indexPath.row];
    
    NSDictionary *dict = notification.userInfo;
    
    editDate.infoResult = [dict objectForKey:@"resultText"];
    editDate.dateResult = notification.fireDate;
    editDate.isDetail = YES;
    
    [self.navigationController pushViewController:editDate animated:YES];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return self.arrayEvents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UILocalNotification *notification = [self.arrayEvents objectAtIndex:indexPath.row];
   
    NSDictionary *dict = notification.userInfo;
    cell.textLabel.text = [dict objectForKey:@"resultText"];
    cell.detailTextLabel.text = [dict objectForKey:@"resultDate"];
   
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
