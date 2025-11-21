//
// © 2024-present https://github.com/cengiz-pz
//

#ifndef gdp_converter_h
#define gdp_converter_h

#import <Foundation/Foundation.h>
#include "core/object/class_db.h"


@interface GDPConverter : NSObject

// From Godot


// To Godot
+ (String) nsStringToGodotString:(NSString*) nsString;
+ (Dictionary) nsDictionaryToGodotDictionary:(NSDictionary*) nsDictionary;
+ (Dictionary) nsUrlToGodotDictionary:(NSURL*) status;

@end

#endif /* gdp_converter_h */
