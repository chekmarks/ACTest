//
// Created by Chris Hatton on 05/04/2013.
//

#import <Foundation/Foundation.h>

@interface ACContactListDeserializer : NSObject <NSXMLParserDelegate>

- (NSOrderedSet*)contactListFromData:(NSData *)contactListData
                               error:(NSError**)errorRef;

@end