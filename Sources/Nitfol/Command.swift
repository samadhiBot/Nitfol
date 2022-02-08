//
//  Command.swift
//  Nitfol
//
//  Created by Chris Sessions on 2/5/22.
//

import Foundation

public struct Command: Equatable {
    public static let startGame = Command(verb: UUID().uuidString)

    public let verb: String?
    public let directObj: String?
    public let directObjMods: [String]
    public let preposition: String?
    public let indirectObj: String?
    public let indirectObjMods: [String]

    init(
        verb: String?,
        directObj: String? = nil,
        directObjMods: [String] = [],
        preposition: String? = nil,
        indirectObj: String? = nil,
        indirectObjMods: [String] = []
    ) {
        self.verb = verb
        self.directObj = directObj
        self.directObjMods = directObjMods
        self.preposition = preposition
        self.indirectObj = indirectObj
        self.indirectObjMods = indirectObjMods
    }
}

//extension Command: CustomStringConvertible {
//    public var description: String {
//        """
//        verb: \(verb ?? "")
//        dOjb: \((directObjMods + [directObj]).compactMap { $0 }.joined(separator: " "))
//        prep: \(preposition ?? "")
//        iObj: \((indirectObjMods + [indirectObj]).compactMap { $0 }.joined(separator: " "))
//        """
//    }
//}
