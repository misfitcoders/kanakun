//
//  kanakunTests.swift
//  kanakunTests
//
//  Created by Enrique Perez Velasco on 19/07/2020.
//

import XCTest
@testable import kanakun
import jisho_swift
import wanakana_swift
import Combine

class kanakunTests: XCTestCase {
    
    let gamePlayController = GamePlayController.game

    func testGameControler_Singleton() {
        let gamePlayControllerB = GamePlayController.game
        gamePlayController.cursor = 1
        XCTAssertTrue( gamePlayController.cursor == gamePlayControllerB.cursor)
        gamePlayController.resetGame()
        XCTAssertTrue( gamePlayController.cursor == gamePlayControllerB.cursor)
    }
    
    func testGameControler_StartGameWith() {
        let expectation = XCTestExpectation(
            description: "fetch proverbs from Jisho and Furigana for first item in results"
        )
        var gameContent = [Tokenized]()
        guard let result = try? Jisho.searchFor(
                term: .Proverb, page: 1) else {
            XCTFail()
            return
        }
        
        let cancellableJisho = result.sink(
            receiveCompletion: { print($0) }) { jishoResult in
            guard let content = jishoResult.data.first?.japanese.first?.reading?.tokenizedAll
            else {
                XCTFail()
                return
            }
            gameContent = content
            expectation.fulfill()
        }
            
        wait(for: [expectation], timeout: 20)
        XCTAssertNotNil(cancellableJisho)
        XCTAssertFalse(gameContent.isEmpty)
        
        // Initialize Game
        XCTContext.runActivity(named: "initialize game") { _ in
            let expectation = XCTestExpectation(
                description: "initialize game in main thread"
            )
            gamePlayController.startGameWith(content: gameContent)
            let cancellable = gamePlayController.content.publisher.sink { _ in
                expectation.fulfill()
            }
            XCTAssertNotNil(cancellable)
            wait(for: [expectation], timeout: 5)
            XCTAssertFalse(gamePlayController.content.isEmpty)
            XCTAssertGreaterThan(gamePlayController.allCharacters.count, 1)
        }
        
        // Retrieve the game pad items
        XCTContext.runActivity(named: "fetch game pad items") {_ in
            let items = gamePlayController.generatePadItems()
            XCTAssertEqual(items.uniques.count, 25)
        }
        
        // Pass failures thru the game
        XCTContext.runActivity(named: "pass failures thru game") {_ in
            let characters = gamePlayController.allCharacters
            characters.reversed().forEach { string in
                gamePlayController.checkAnswer(string)
            }
            XCTAssertEqual(gamePlayController.failed, characters.count - 1)
        }
        
        // Pass succesfully thru the game
        XCTContext.runActivity(named: "pass successfully thru game") {_ in
            let characters = gamePlayController.allCharacters
            characters.forEach { string in
                gamePlayController.checkAnswer(string)
            }
            XCTAssertTrue(gamePlayController.success)
        }
        
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
