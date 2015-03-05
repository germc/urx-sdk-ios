# URX iOS SDK
The URX iOS SDK is a wrapper for URX's Deep Link Search API. 

To receive your API key, please visit [dashboard.urx.com](http://dashboard.urx.com).

## Setup:
###Step 1: Add the URXSearch Framework to your Project**:
First, clone this repository. Then, drag and drop the ``URXSearch.xcodeproj`` into the "Frameworks" directory of your project.


###Step 2: Linking to URXSearch Binaries and Headers**:
Make sure that the ``URXSearch.framework`` has been added to your project's binary. In your project settings, select your ``Target`` and select the ``Build Phases`` tab.  In the ``Link Binary With Libraries`` phase you should see ``URXSearch.framework``. If not, hit the + button and select it from the list of options.


###Step 3: Set up the API Key**:
Before you can use the SDK, you must provide your URX API Key. To do this, add a `String` row to your Info.plist file with ``URX API Key`` as the key and your API key as the value. Contact support@urx.com for an API key if you don't already have one.

###Step 4: Set -ObjC linker flag**:
In your project's Build Settings, make sure to add -ObjC in the "Other Linker Flags" setting.

## Basic Usage:
###### Data from Search Results
```objective-c
#import <URXSearch/URXTerm.h>
#import <URXSearch/URXSearchResult.h>

...

[[URXTerm termWithKeywords:@"ellie goulding"] searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
    // SEARCH SUCCESS HANDLER
    URXSearchResult *result = response.results[0];
    // The Search Result Content's Title
    NSLog(@"%@", result.name);
    // The Search Result Content's image url
    NSLog(@"%@", result.imageUrl);
    // The Search Result Content's longer text description
    NSLog(@"%@", result.descriptionText);
    // The Search Result Content's call to action text (ie. "Buy Tickets")
    NSLog(@"%@", result.callToActionText);
} andFailureHandler:^(URXAPIError *error) {
    // SEARCH FAILURE HANDLER
    NSLog(@"%@", error.errorMessage);
}];
```
###### Search & Resolve with App Store Fallback
```objective-c
#import <URXSearch/URXTerm.h>
#import <URXSearch/URXSearchResult.h>

...

[[URXTerm termWithKeywords:@"ellie goulding"] searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
    // SEARCH SUCCESS HANDLER
    // Note: Integrations usually display the search result for the user
    // and set click handler to trigger resolving user to destination.
    // Resolve to the deeplink only if the app is installed,
    // otherwise fallback to the app store.
    [response.results[0] resolveAsynchronouslyWithAppStoreFallbackAndFailureHandler:^(URXAPIError *error) {
        NSLog(@"%@", error.errorMessage);
    }];
} andFailureHandler:^(URXAPIError *error) {
    // SEARCH FAILURE HANDLER
    NSLog(@"%@", error.errorMessage);
}];
```
## Search Operators:

###### Basic Keyword Search
```objective-c
#import <URXSearch/URXTerm.h>

...

[[URXTerm termWithKeywords:@"ellie goulding"] searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
    // SEARCH SUCCESS HANDLER
} andFailureHandler:^(URXAPIError *error) {
    // SEARCH FAILURE HANDLER
}];
```

###### Exact Phrase Match
```objective-c
#import <URXSearch/URXPhrase.h>

...

[[URXPhrase phraseWithString:@"ellie goulding"] searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
    // SEARCH SUCCESS HANDLER
} andFailureHandler:^(URXAPIError *error) {
    // SEARCH FAILURE HANDLER
}];
```

###### Filter by Action
```objective-c
#import <URXSearch/URXTerm.h>
#import <URXSearch/URXActionFilter.h>
#import <URXSearch/URXAnd.h>

...

[[[URXTerm termWithKeywords:@"ellie goulding"] and:[URXActionFilter listenAction]] searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
    // SEARCH SUCCESS HANDLER
} andFailureHandler:^(URXAPIError *error) {
    // SEARCH FAILURE HANDLER
    NSLog(@"%@", error.errorMessage);
}];
```

###### Filter by Domain
```objective-c
#import <URXSearch/URXTerm.h>
#import <URXSearch/URXDomainFilter.h>
#import <URXSearch/URXAnd.h>

...

[[[URXTerm termWithKeywords:@"ellie goulding"] and:[URXDomainFilter domainWithPLD:@"spotify.com"]] searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
    // SEARCH SUCCESS HANDLER
} andFailureHandler:^(URXAPIError *error) {
    // SEARCH FAILURE HANDLER
    NSLog(@"%@", error.errorMessage);
}];
```

###### Geo Search
```objective-c
#import <URXSearch/URXTerm.h>
#import <URXSearch/URXNearFilter.h>
#import <URXSearch/URXAnd.h>

...

[[[URXTerm termWithKeywords:@"ellie goulding"] and:[URXNearFilter nearLatitude:37.7811919 AndLongitude:-122.3950664]] searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
    // SEARCH SUCCESS HANDLER
} andFailureHandler:^(URXAPIError *error) {
    // SEARCH FAILURE HANDLER
    NSLog(@"%@", error.errorMessage);
}];
```

For more advanced boolean operations and complex queries, see the [API Search Operators documentation](http://developers.urx.com/reference/search-operators.html).

## Advanced Usage:
###### Search With Raw Query String
```objective-c
#import <URXSearch/URXRawQuery.h>

...

[[URXRawQuery queryFromString:@"ellie goulding action:BuyAction near:\"San Francisco\""] searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
    // SEARCH SUCCESS HANDLER
} andFailureHandler:^(URXAPIError *error) {
    // SEARCH FAILURE HANDLER
}];
```

###### Search & Resolve with Web Fallback
```objective-c
#import <URXSearch/URXTerm.h>
#import <URXSearch/URXSearchResult.h>

...

[[URXTerm termWithKeywords:@"ellie goulding"] searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
    // SEARCH SUCCESS HANDLER
    // Note: Integrations usually display the search result for the user
    // and set click handler to trigger resolving user to destination.
    // Resolve to the deeplink only if the app is installed,
    // otherwise fallback to the web page.
    [response.results[0] resolveAsynchronouslyWithWebFallbackAndFailureHandler:^(URXAPIError *error) {
        NSLog(@"%@", error.errorMessage);
    }];
} andFailureHandler:^(URXAPIError *error) {
    // SEARCH FAILURE HANDLER
    NSLog(@"%@", error.errorMessage);
}];
```
###### Resolve Url with App Store Fallback
```objective-c
#import <URXSearch/URXResolutionRequest.h>

...

[[URXResolutionRequest requestFromUrl:@"http://www.spotify.com"] resolveAsynchronouslyWithAppStoreFallbackAndFailureHandler:^(URXAPIError *error) {
    // RESOLUTION FAILURE HANDLER
    NSLog(@"%@", error.errorMessage);
}];
```
###### Resolve Url with Web Fallback
```objective-c
#import <URXSearch/URXResolutionRequest.h>

...

[[URXResolutionRequest requestFromUrl:@"http://www.spotify.com"] resolveAsynchronouslyWithWebFallbackAndFailureHandler:^(URXAPIError *error) {
    // RESOLUTION FAILURE HANDLER
    NSLog(@"%@", error.errorMessage);
}];
```

License
-------
Copyright 2015 URX

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
