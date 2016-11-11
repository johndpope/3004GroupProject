//
//  STDatabase.h
//  STDatabase
//
//  Created by Ryan DiCintio on 2016-11-10.
//  Copyright © 2016 3004Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import RealmSwift

#import <STDatabase/STClients.swift>
#import <STDatabase/STPosts.swift>
#import <STDatabase/STSession.swift>

//! Project version number for STDatabase.
FOUNDATION_EXPORT double STDatabaseVersionNumber;

//! Project version string for STDatabase.
FOUNDATION_EXPORT const unsigned char STDatabaseVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <STDatabase/PublicHeader.h>


@interface STSession : NSObject

@property NSString  session_name
@property NSString  session_password
@property NSArray   content_type[NSString]
@property Int       num_items_onscreen
@property STChromecastConfig chromecast_id
@property Bool      auto_mod


@end


@interface STPosts : NSObject

@property STPostType    post_type
@property NSString      body
@property NSURL         image_url
@property NSData        image_data
@property NSURL         video_url
@property STModStatus   mod_status
@property NSDate        submission_time

@end


@interface STClients : NSObject

@property NSString      username
@property NSUUID        session_id

@end
