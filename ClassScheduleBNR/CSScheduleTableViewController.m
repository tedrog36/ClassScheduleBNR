//
//  ScheduleTableViewController.m
//  ClassSchedule
//
//  Created by Ted Rogers on 2/15/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import "CSScheduleTableViewController.h"
#import "CSClassRegions.h"
#import "CSClassRegion.h"
#import "CSClass.h"
#import "CSScheduleStore.h"
#import "CSClassCell.h"
#import "WebViewController.h"

// custom table cell information
#define CELL_TYPE CSClassCell
#define CELL_TYPE_NAME @"CSClassCell"

@interface CSScheduleTableViewController ()
{
    CSClassRegions *classRegions;
    NSDateFormatter *dateFormatter;
    NSString *currencyUS;
    NSString *currencyNL;
}
@end


@implementation CSScheduleTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        [self setTitle:@"BNR Class Schedule"];
        
        // setup date formatter for displaying class schedule dates
        dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *localeUSPOSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormatter setLocale:localeUSPOSIX];
        [dateFormatter setDateFormat:@"MMM d"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

        // create locale for Netherlands currency
        NSLocale* localeNL = [[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"];
        NSNumberFormatter* currencyFormatter = [[NSNumberFormatter alloc] init];
        
        // get currency symbols for US and NL
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [currencyFormatter setLocale:localeNL];
        currencyNL = [currencyFormatter currencySymbol];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [currencyFormatter setLocale:localeUSPOSIX];
        currencyUS = [currencyFormatter currencySymbol];
        
        // only allow selection on the iPhone for displayed webview of class description
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            [[self tableView] setAllowsSelection:NO];
        }
        
        // go get the class schedule information
        [self fetchEntries];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // load the nib for our custom table cell
    UINib *nib = [UINib nibWithNibName:CELL_TYPE_NAME bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:CELL_TYPE_NAME];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numSections = 1;
    if (classRegions != nil) // did we receive the data yet?
    {
        numSections = [[classRegions items] count];
    }
    return numSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRows = 0;
    if (classRegions != nil) // did we receive the data yet?
    {
        CSClassRegion *region = [[classRegions items] objectAtIndex:section];
        numRows = [[region items] count];
    }
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get our custom cell
    CELL_TYPE *cell = [tableView dequeueReusableCellWithIdentifier:CELL_TYPE_NAME];
    
    if ([cell moreInfoButton] != nil) // only have the button on the iPad
        [[cell moreInfoButton] addTarget:self action:@selector(moreInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    // set the data into the cell
    int section = [indexPath section];
    CSClassRegion *region = [[classRegions items] objectAtIndex:section];
    int row = [indexPath row];
    CSClass *class = [[region items] objectAtIndex:row];
    NSString *begins = [dateFormatter stringFromDate:[class classBegins]];
    NSString *ends = [dateFormatter stringFromDate:[class classEnds]];
    NSString *date = [NSString stringWithFormat:@"%@ - %@", begins, ends];
    [[cell dateLabel] setText:date];
    [[cell courseLabel] setText:[class title]];
    [[cell instructorLabel] setText:[class instructor]];
    NSString *currency;
    if ([class currency] == 1)
        currency = currencyNL;
    else // 0
        currency = currencyUS;
    [[cell priceLabel] setText:[NSString stringWithFormat:@"%@%d", currency, [class price]]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CSClassRegion *classRegion = [[classRegions items] objectAtIndex:section];
    return [classRegion name];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        // instead of "More Info" button, we use table row selection to use WebView
        [self moreInfoWithIndexPath:indexPath];
    }
}

- (void)fetchEntries
{
    // get ahold of the segmented control that is currrently in the title view
    UIView *currentTitleView = [[self navigationItem] titleView];
    
    // create an activity indication and start is spinning in the nav bar
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [[self navigationItem] setTitleView:aiView];
    [aiView startAnimating];
    
    void (^completionBlock)(id obj, NSError *err) =
    ^(id obj, NSError *err)
    {
        // set back old title view
        [[self navigationItem] setTitleView:currentTitleView];
        if (!err)
        {
            // we got our data, reload the table
            classRegions = obj;
            [[self tableView] reloadData];
        }
        else
        {
            // badness!
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:[err localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [av show];
        }
    };
    CSClassRegions *newClassRegions = [[CSClassRegions alloc] init];
    [[CSScheduleStore sharedStore] fetchBNRSchedule:newClassRegions withCompletion:completionBlock];
}

- (void)moreInfo:(id)sender
{
    // get the indexPath from the button
    UIButton *senderButton = (UIButton *)sender;
    UIView *cellContentView = [senderButton superview];
    CELL_TYPE *cell = (CELL_TYPE *)[cellContentView superview];
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    // load the WebView based on the indexPath
    [self moreInfoWithIndexPath:indexPath];
}

- (void)moreInfoWithIndexPath:(NSIndexPath *)indexPath
{
    // grab the web page link for this indexPath
    int section = [indexPath section];
    int row = [indexPath row];
    CSClassRegion *region = [[classRegions items] objectAtIndex:section];
    CSClass *class = [[region items] objectAtIndex:row];
    NSString *urlString = [NSString stringWithFormat:@"http://www.bignerdranch.com/%@", [class publicPath]];
    
    // init the WebViewController, we use this to provide activity inidicator view
    WebViewController *wvc = [[WebViewController alloc] initWithFrame:[[self view] frame] withUrlString:urlString];
    [wvc setTitle:[class title]];
    
    // show it!
    [[self navigationController] pushViewController:wvc animated:YES];
}
@end
