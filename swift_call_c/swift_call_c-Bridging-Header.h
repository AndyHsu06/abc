//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

////// Query

BOOL  has_this_guy(NSString* account, NSString* password);
NSArray* get_numbers_from_db(NSString* column);
NSArray* get_strings_from_db(NSString* column);
NSArray* get_pictures_from_db(NSString* column);

////// Non query

BOOL insert_new_record(NSInteger number,NSString* name, NSInteger score, UIImage* picture);

