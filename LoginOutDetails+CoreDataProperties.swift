//
//  LoginOutDetails+CoreDataProperties.swift
//  
//
//  Created by Apogee on 6/15/17.
//
//

import Foundation
import CoreData


extension LoginOutDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginOutDetails> {
        return NSFetchRequest<LoginOutDetails>(entityName: "LoginOutDetails")
    }

    @NSManaged public var logi: NSDate?
    @NSManaged public var logout: NSDate?

}
