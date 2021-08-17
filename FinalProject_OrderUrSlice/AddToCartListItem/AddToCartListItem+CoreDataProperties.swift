//
//  AddToCartListItem+CoreDataProperties.swift
//  FinalProject_OrderUrSlice
//
//  Created by Saurav Arya on 17/08/21.
//
//

import Foundation
import CoreData


extension AddToCartListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddToCartListItem> {
        return NSFetchRequest<AddToCartListItem>(entityName: "AddToCartListItem")
    }

    @NSManaged public var pizzaItem: String?

}

extension AddToCartListItem : Identifiable {

}
