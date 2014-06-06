//
//  TSViewController.m
//  ParticipaPoa
//
//  Created by Cristiano Fernandes on 5/24/14.
//  Copyright (c) 2014 Azapp Software. All rights reserved.
//

#import "TSViewController.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

@interface TSViewController ()

@end

@implementation TSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    UIBarButtonItem *nextViewBackButton = [[UIBarButtonItem alloc]
                                           initWithTitle: @"Voltar"
                                           style:UIBarButtonItemStyleBordered
                                           target:nil
                                           action:nil];

    [self.navigationItem setBackBarButtonItem:nextViewBackButton];

    [self.navigationItem setTitle:@"ParticipaPOA"];

    _records = [[NSArray alloc] init];
    [self getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_records count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    NSDictionary *dict = [_records objectAtIndex:indexPath.row];
    NSString *desc = [dict objectForKey:@"Descri\u00e7\u00e3o Demanda"];
//    NSString *desc = [dict objectForKey:@"Tema"];
    [cell.textLabel setText:desc];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detalhes" sender:tableView];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TSDetalheViewController *detalhesVC = segue.destinationViewController;
    NSIndexPath *indexPath = [_tableView indexPathForSelectedRow];
    [detalhesVC setDetalhes:[_records objectAtIndex:indexPath.row]];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)getData
{
    NSString *requestStr = @"http://datapoa.com.br/api/action/datastore_search?resource_id=f93afcda-c909-43a0-9924-db19e0a94427";

    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://datapoa.com.br"]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:requestStr
                                                      parameters:nil];
    [self startedLoading];

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *dataDict = JSON;

        NSDictionary *result = [dataDict objectForKey:@"result"];
        _records = [[NSArray alloc] initWithArray:[result objectForKey:@"records"]];

        [_tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@", [error userInfo]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro"
                                                        message:@"Erro ao baixar os dados."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
    [operation start];
}

- (void)startedLoading
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Carregando";
}

@end
