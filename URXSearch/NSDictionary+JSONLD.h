//
//  NSDictionary+JSONLD.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>

/** A category for NSDictionary which lets you access data in a consistent way when working with JSONLD, where any value can be either scalar or vector (single value or list of values).
 
    Example code:
        // Assume that `[MyMusicData getMusicAlbum]` returns an `NSDictionary` representing data of the Schema.org type MusicAlbum (http://schema.org/MusicAlbum) as JSONLD. In this example, we want to get all of the track names from that album.
        NSDictionary *jsonldMusicAlbum = [MyMusicData getMusicAlbum];
        // As all JSONLD values can be scalar or vector (single value or list of values), but in this case we want to look at all tracks in this album (if any exist, otherwise we'll just get an empty array back).
        [[jsonldMusicAlbum getMany:@"track"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
             // Here we cast the `id obj` to an `NSDictionary`. Its worth being defensive here in cases where either a Schema.org entity type (an `NSDictionary`) or data type (such as a string, number, boolean value, or date/time). In this case, looking at the Schema.org definition for MusicAlbum, we know that this field should return a MusicRecording entity (http://schema.org/MusicRecording).
             NSDictionary *musicRecording = obj;
             NSString *trackName = [someEntity getSingle:@"name"];
             // We need to check to see if the value is nil, because this data may not have a name associated with it (although it very likely does).
             if (trackName != nil) {
                 // Finally, we can use the bit of data we wanted.
                 NSLog(@"Listen to %@", trackName);
             }
        }];
 
 */

@interface NSDictionary (JSONLD)

/** A method for extracting scalar values from an NSDictionary.
 
 @param NSString represents the key whose value you want to extract.
 @return Returns a single object representing the value for the provided key.
 @warning The returned value may be nil, NSDictionary, NSString, NSNumber, or NSDate depending on the data available. It is recommended to defensively nil and type check when accessing data in this manner.
 
 */
- (id)getSingle:(NSString *)key;

/** A method for extracting vector values from an NSDictionary.
 
 @param NSString represents the key whose values you want to extract.
 @return The returned array is a list of multiple objects representing the value for the provided key.
 @warning The values in the returned array may be nil, NSDictionary, NSString, NSNumber, NSDate, or a combination of those therein, depending on the data available. It is recommended to defensively nil and type check when accessing data in this manner.
 
 */
- (NSArray *)getMany:(NSString *)key;

@end
