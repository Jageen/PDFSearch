//
//  VCSearchPDF.m
//  sasol
//
//  Created by Jageen on 15/10/15.
//  Copyright (c) 2015 Jageen. All rights reserved.
//

#import "VCSearchPDF.h"
#import "WebViewPDF.h"

@interface VCSearchPDF ()<UITextFieldDelegate>
{
    // Responsible for display PDF file
    WebViewPDF *pdfViewer;
    __weak IBOutlet UITextField *txtSearch;
}
@end

@implementation VCSearchPDF

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    pdfViewer = [[WebViewPDF alloc] initWithFrame:self.view.bounds];
    CGRect frame = pdfViewer.frame;
    frame.origin.y += 60;
    pdfViewer.frame = frame;
    [self.view addSubview:pdfViewer];
    
    // Disbale scroll bounce
    pdfViewer.scrollView.bounces = NO;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *pdfFilePath = [[NSBundle mainBundle] pathForResource:@"compressed.tracemonkey-pldi-09" ofType:@"pdf"];
    [pdfViewer loadPDF:pdfFilePath];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextfield delegates
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [pdfViewer search:textField.text];
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    {
        [pdfViewer search:finalString];
    }
    return YES;
}

#pragma mark - handel click event
- (IBAction)btnPreviusClicked:(id)sender {
    [pdfViewer previousSearchResult];
}

- (IBAction)btnNextClicked:(id)sender {
    [pdfViewer nextSearchResult];
}

//- (IBAction)btnHighlightedClicked:(UIButton*)sender {
//    [pdfViewer setHighliteSearch:sender.isSelected];
//}
//
//- (IBAction)btnCaseSensitiveClicked:(UIButton*)sender {
//    [pdfViewer setCasesensitiveSearch:sender.isSelected];
//}

@end
