//
//  WebViewController.m
//  ClassSchedule
//
//  Created by Ted Rogers on 3/4/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *aiView;
@property (nonatomic, strong) UIView *currentTitleView;

@end

@implementation WebViewController

- (id)initWithFrame:(CGRect)frame withUrlString:(NSString*)urlString
{
    self = [super init];
    if (self)
    {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:[[self view]frame]];
        [webView setDelegate:self];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        
        [webView setScalesPageToFit:YES];
        [self setView:webView];
        [webView loadRequest:req];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%@ isLoading = %d", NSStringFromSelector(_cmd), (int)[webView isLoading]);
   if ([self aiView] == nil)
    {
        [self setCurrentTitleView:[[self navigationItem] titleView]];
        UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self setAiView:aiView];
        [[self navigationItem] setTitleView:aiView];
        [aiView startAnimating];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%@ isLoading = %d", NSStringFromSelector(_cmd), (int)[webView isLoading]);
    if (![webView isLoading] && ([self aiView] != nil))
    {
        [[self navigationItem] setTitleView:[self currentTitleView]];
        [self setCurrentTitleView:nil];
        [self setAiView:nil];
    }
}

@end
