//
//  WebViewPDF.h
//  sasol
//
//  Created by Jageen on 15/10/15.
//  Copyright (c) 2015 Jageen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Responsible for display pdf file in web view using PDF.js
 and perform search.
 **/
@interface WebViewPDF : UIWebView

/**
 PDF file path for display
 **/
@property (readonly) NSString *filePath;

@property (readonly) NSString *searchString;

/**
 Load pdf file into web view
 **/
-(void) loadPDF:(NSString*)filePath;

/**
 Display page number of pdf file
 **/
-(void) showPage:(NSInteger*)page;

/**
 Search stirng in pdf file
 **/
-(void) search:(NSString*)searchStirng;

/**
 Search stirng in pdf file.
 \param isHighliteSearch highlite search all result
 \param isCasesensitive perform search with case sensitive
 **/
-(void) search:(NSString*)searchStirng withHighliteSearch:(BOOL)isHighliteSearch withCasesencitive:(BOOL)isCasesensitive;

/**
 Perform next search result
 **/
-(void) nextSearchResult;

/**
 Perform previous search result
 **/
-(void) previousSearchResult;

/**
 Highlte all search result
 **/
-(void) setHighliteSearch:(BOOL) isHighliteSearch;

/**
 Display result on base of case sensitive value
 **/
-(void) setCasesensitiveSearch:(BOOL) isCasesensitiveSearch;

@end
