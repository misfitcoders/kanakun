//
//  kanakunTests.swift
//  kanakunTests
//
//  Created by Enrique Perez Velasco on 19/07/2020.
//

import XCTest
@testable import kanakun
import jisho_swift
import Combine

class kanakunTests: XCTestCase {
    
    let gamePlayController = GamePlayController.game

    func testGameControler_Singleton() {
        let gamePlayControllerB = GamePlayController.game
        gamePlayController.cursor.character = 1
        XCTAssertTrue( gamePlayController.cursor.character == gamePlayControllerB.cursor.character)
        gamePlayController.resetGame()
        XCTAssertTrue( gamePlayController.cursor.character == gamePlayControllerB.cursor.character)
    }
    
    func testGameControler_StartGameWith() {
        let expectation = XCTestExpectation(
            description: "fetch proverbs from Jisho and Furigana for first item in results"
        )
        var gameContent = [FuriganaEntry]()
        guard let result = try? Jisho.searchFor(
                term: .Proverb, page: 1) else {
            XCTFail()
            return
        }
        
        var cancellableFurigana: AnyCancellable?
        let cancellableJisho = result.sink(
            receiveCompletion: { print($0) }) { jishoResult in
            guard let furiganaResult = try?  Jisho.getFurigana(forJishoEntry: jishoResult.data.first!) else {
                XCTFail()
                return
            }
            cancellableFurigana = furiganaResult.sink(
                receiveCompletion: { print($0) },
                receiveValue: { furiganaEntry in
                    gameContent = furiganaEntry.furigana
                    expectation.fulfill()
                })
        }
        wait(for: [expectation], timeout: 20)
        XCTAssertNotNil(cancellableFurigana)
        XCTAssertNotNil(cancellableJisho)
        XCTAssertFalse(gameContent.isEmpty)
        
        // Initialize Game
        XCTContext.runActivity(named: "initialize game") { _ in
            gamePlayController.startGameWith(content: gameContent)
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
            characters.reversed().forEach { character in
                gamePlayController.checkAnswer(forInput: String(character))
            }
            XCTAssertEqual(gamePlayController.failed, characters.count - 1)
        }
        
        // Pass succesfully thru the game
        XCTContext.runActivity(named: "pass successfully thru game") {_ in
            let characters = gamePlayController.allCharacters
            characters.forEach { character in
                gamePlayController.checkAnswer(forInput: String(character))
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
