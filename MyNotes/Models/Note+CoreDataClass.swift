//
//  Note+CoreDataClass.swift
//  MyNotes
//
//  Created by Gözde Aydin on 16.02.2025.
//
//

import CoreData
import Foundation

@objc(Note)
public class Note: NSManagedObject {
    var title: String {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? "" // returns the first line of the text
    }

    var desc: String {
        if var lines = text?.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines) {
            lines.removeFirst()
            return "\(String(describing: lastUpdated?.format()) ) \(lines.first ?? "")" // return second line
        } else {
            return ""
        }
    }
}

/*
 var title: String {
     return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? "" // returns the first line of the text
 }

 var desc: String {
     var lines = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
     lines.removeFirst()
     return "\(lastUpdated.format()) \(lines.first ?? "")" // return second line
 }
 */
