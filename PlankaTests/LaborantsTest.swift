//
//  LaborantsTest.swift
//  PlankaTests
//
//  Created by Anton Vlezko on 22.10.2021.
//

import XCTest
@testable import Planka

class MockLaborantsView: LaborantsViewProtocol {
    var laborants: [Laborant] = []
    func setLaborants(laborants: [Laborant]) {
        self.laborants = laborants
    }
}


class LaborantsTest: XCTestCase {
    
    var view: MockLaborantsView!
    var laborants: [Laborant]!
    var presenter: LaborantsPresenter!
    
    override func setUp() {
        view = MockLaborantsView()
        laborants = [
            Laborant(name: "Baz"),
            Laborant(name: "Bar")
        ]
        presenter = LaborantsPresenter(view: view, laborants: laborants)
    }
    
    override func tearDown() {
        view = nil
        laborants = nil
        presenter = nil
    }

    func testModuleIsNotNill() {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
    }
    
    func testLaborantAdd() {
        let laborant = Laborant(name: "Foo")
        presenter.addLaborant(laborant: laborant)
        
        let containsLaborant = view.laborants.contains(where: {$0.id == laborant.id})
        XCTAssertTrue(containsLaborant, "view contains laborant from presenter")
    }
}
