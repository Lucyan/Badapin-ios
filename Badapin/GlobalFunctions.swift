//
//  GlobalFunctions.swift
//  Badapin
//
//  Created by Leonardo Olivares on 19-04-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import Foundation

/**
A utility class for working with regular expressions, `RegularExpression` simplifies matching on "regex" patterns. The class
works with the infix `=~` operator to provide super-easy support for regular expression pattern matching. The underlying
implementation is based on `NSRegularExpression` and utilizes the full power available therein.
Using `RegularExpression` is simple. It can be used to match against any expression using the `matches()` function, which returns
a boolean indication of whether or not the expression successfully matched:
>	`RegularExpression("\\w{5}").matches("Hello") // return true`
>	`RegularExpression("\\w{5}").matches("123") // returns false`
- seealso: infix operator `=~`
- seealso: `matches(input: String)`
*/

class Regex {
    private let internalExpression: NSRegularExpression?
    private let pattern: String
    
    /// Initializer that takes a regular expression, provided as an escaped `String`. The provided `String` becomes the
    /// regular expression.
    ///
    /// - parameters:
    ///	- pattern: A `String` representing a regular expression (eg., "\\w{5}").
    
    init(_ pattern: String) {
        self.pattern = pattern
        self.internalExpression = try? NSRegularExpression(pattern: pattern, options: .AnchorsMatchLines)
    }
    
    /// Returns a boolean indication of whether or not the receiver's regular expression successfully matches the provided `String`.
    /// Note that if the regular expression is defective the method will return `false`.
    ///
    /// - parameters:
    ///	- input: A `String` to match against the regular expression.
    ///
    /// - returns: A boolean indication of success. Returns `false` if the regular expression is invalid or if the string does not match.
    
    func test(input: String) -> Bool {
        let matches = self.internalExpression?.matchesInString(input, options: .ReportCompletion, range:NSMakeRange(0, input.characters.count))
        return matches?.count > 0
    }
}

infix operator =~ {}

/**
Infix regular expression matching operator that compares a `String` to a regular expression (also represented as a `String`). For
example:
>	`"word" =~ "\\w+" // returns true`
*/

func =~ (input: String, pattern: String) -> Bool {
    return Regex(pattern).test(input)
}


func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
    NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
        completion(data: data)
        }.resume()
}

func downloadImage(url:NSURL, completion: (Bool, NSData?) -> Void){
    //print("Started downloading \"\(url.URLByDeletingPathExtension)\".")
    getDataFromUrl(url) { data in
        dispatch_async(dispatch_get_main_queue()) {
            //print("Finished downloading \"\(url.URLByDeletingPathExtension)\".")
            completion(true, data)
        }
    }
}