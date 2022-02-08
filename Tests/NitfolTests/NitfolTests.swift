import XCTest
@testable import Nitfol

final class NitfolTests: XCTestCase {
    let nitfol = try! Nitfol()

    func testOpenMailbox() {
        XCTAssertEqual(
            nitfol.parse("Open the mailbox"),
            Command(verb: "open", directObj: "mailbox")
        )
    }

    func testKillTheTroll() {
        XCTAssertEqual(
            nitfol.parse("Kill the menacing troll with the brightly glowing sword"),
            Command(
                verb: "kill",
                directObj: "troll",
                directObjMods: ["menacing"],
                preposition: "with",
                indirectObj: "sword",
                indirectObjMods: ["brightly", "glowing"]
            )
        )
    }
}
