//
//  WordEntity+CoreDataProperties.swift
//  TrainEnglishApp
//
//  Created by Nikita Skripka on 07.02.2024.
//
//

import Foundation
import CoreData


extension WordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordEntity> {
        return NSFetchRequest<WordEntity>(entityName: "WordEntity")
    }

    @NSManaged public var englishWord: String?
    @NSManaged public var russianWord: String?
    @NSManaged public var wordID: UUID?
    @NSManaged public var wordImage: Data?
    @NSManaged public var wordLevel: String?

}

extension WordEntity : Identifiable {

}
