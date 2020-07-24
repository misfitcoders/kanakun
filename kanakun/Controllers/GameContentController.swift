//
//  GameContentController.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 22/07/2020.
//

import Foundation
import SwiftUI
import Combine
import CoreData
import jisho_swift
import wanakana_swift

class GameContentController: ObservableObject {
    
    @Published var content: Play?
    let context: NSManagedObjectContext
    
    var fetchOffset = 0
    let nonPlayedContentPredicate = NSPredicate(
        format: "played == 0"
    )
    let failedContentPredicate = NSPredicate(
        format: "failed > 0"
    )
    
    
    func requestPlays(
        _ predicate: NSPredicate? = nil) -> NSFetchRequest<Play> {
        let request = NSFetchRequest<Play>(entityName: "Play")
        request.predicate = predicate
        request.fetchLimit = 1
        request.fetchOffset = fetchOffset
        request.returnsObjectsAsFaults = false
        return request
    }
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    func updateCurrentContent(
        failed: Int? = nil,
        played: Bool? = nil
        ) {
        if content != nil {
            do {
                content!.setValuesForKeys([
                    "failed" : failed ?? content!.failed,
                    "played" : played ?? content!.played
                ])
                try context.save()
            } catch {
                print("An error occurred while updating current content \(error.localizedDescription)")
            }
        }
    }
    
    
    /// Starts a new game with next available content
    /// - Parameter failed: The failures of the previously played game if any
    /// - Returns: A game content item fetched from database
    func next(failed: Int? = nil) -> Play? {

        if failed != nil {
            updateCurrentContent(
                failed: failed,
                played: true
            )
        }

        do {
            // Configure fetch request
            let request = NSFetchRequest<Play>(entityName: "Play")
            request.predicate = nonPlayedContentPredicate
            request.fetchLimit = 1
            request.fetchOffset = fetchOffset
            request.returnsObjectsAsFaults = false
            
            // Try to fetch non played content
            var result = try context.fetch(request)
            
            // If no results:
            // try reseting offset of non played content query
            if result.isEmpty {
                fetchOffset = 0
                request.fetchOffset = fetchOffset
                result = try context.fetch(request)
            }
            
            // If no results:
            // then query for any content
            if result.isEmpty {
                request.predicate = nil
                result = try context.fetch(request)
            }
            
            // If no results:
            // try reseting offset of any content query
            if result.isEmpty {
                fetchOffset = 0
                request.fetchOffset = fetchOffset
                request.predicate = nil
                result = try context.fetch(
                    requestPlays()
                )
            }
            
            // If still no results:
            // Throw an error
            if result.isEmpty {
                fatalError("No available content to play")
            }
            
            fetchOffset += 1
            content = result.first!

        } catch {
            print("Failed to load content \(error.localizedDescription)")
        }
        
        return content
        
    }
    
}
