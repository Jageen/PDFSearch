//
//  WebViewPDF.m
//  sasol
//
//  Created by Jageen on 15/10/15.
//  Copyright (c) 2015 Jageen. All rights reserved.
//

#import "WebViewPDF.h"

@interface WebViewPDF()
{
    BOOL _isCasesensitive;
    BOOL _isHighliteSearch;
    
    // Contain search string which will searched after pdf file is loaded
    NSString *searchAfterLoad;
}

@end
@implementation WebViewPDF

-(void) loadPDF:(NSString*)filePath
{
    // Assign new file path to the property
    _filePath = filePath;
    
    NSString *sPath = [[NSBundle mainBundle] pathForResource:@"viewer" ofType:@"html" inDirectory:@"PDFJS/web"];
    NSString *finalPath = [NSString stringWithFormat:@"%@?file=%@#page=1",sPath,filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:finalPath]];
    [self loadRequest:request];
}

/**
 Display page number of pdf file
 **/
-(void) showPage:(NSInteger*)page
{
    NSString *sPath = [[NSBundle mainBundle] pathForResource:@"viewer" ofType:@"html" inDirectory:@"PDFJS/web"];
    NSString *finalPath = [NSString stringWithFormat:@"%@?file=%@#page=%d",sPath,_filePath,(int)page];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:finalPath]];
    [self loadRequest:request];
}

#pragma mark - Search related function
/**
 Search stirng in pdf file
 **/
-(void) search:(NSString*)searchStirng
{
    [self search:searchStirng withHighliteSearch:NO withCasesencitive:NO];
}

/**
 Search stirng in pdf file.
 \param isHighliteSearch highlite search all result
 \param isCasesensitive perform search with case sensitive
 **/
-(void) search:(NSString*)searchStirng withHighliteSearch:(BOOL)isHighliteSearch withCasesencitive:(BOOL)isCasesensitive
{
    _isHighliteSearch = isHighliteSearch;
    _isCasesensitive = isCasesensitive;
    _searchString = searchStirng;
    NSString *javaScript = [NSString stringWithFormat:@"var event = document.createEvent('CustomEvent');event.initCustomEvent('find', true, true, {query: '%@',caseSensitive: %@,highlightAll: %@,findPrevious:false});window.dispatchEvent(event);",_searchString,_isCasesensitive?@"true":@"false",_isHighliteSearch?@"true":@"false"];
    
    [self stringByEvaluatingJavaScriptFromString:javaScript];
}

/**
 Perform next search result
 **/
-(void) nextSearchResult
{
    NSString *javaScript = [NSString stringWithFormat:@"var event = document.createEvent('CustomEvent');event.initCustomEvent('findagain', true, true, {query: '%@',caseSensitive: %@,highlightAll: %@,findPrevious:false});window.dispatchEvent(event);",_searchString,_isCasesensitive?@"true":@"false",_isHighliteSearch?@"true":@"false"];
    
    [self stringByEvaluatingJavaScriptFromString:javaScript];
}

/**
 Perform previous search result
 **/
-(void) previousSearchResult
{
    NSString *javaScript = [NSString stringWithFormat:@"var event = document.createEvent('CustomEvent');event.initCustomEvent('findagain', true, true, {query: '%@',caseSensitive: %@,highlightAll: %@,findPrevious:true});window.dispatchEvent(event);",_searchString,_isCasesensitive?@"true":@"false",_isHighliteSearch?@"true":@"false"];
    [self stringByEvaluatingJavaScriptFromString:javaScript];
}

/**
 Highlte all search result
 **/
-(void) setHighliteSearch:(BOOL) isHighliteSearch
{
    _isHighliteSearch = isHighliteSearch;
}

/**
 Display result on base of case sensitive value
 **/
-(void) setCasesensitiveSearch:(BOOL) isCasesensitive
{
    _isCasesensitive = isCasesensitive;
}

//#pragma mark - UIWebView delegates
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    if(searchAfterLoad.length != 0)
//    {
//        [self search:searchAfterLoad withHighliteSearch:_isHighliteSearch withCasesencitive:_isCasesensitive];
//    }
//}

@end
