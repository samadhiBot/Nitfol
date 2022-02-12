//
//  Generator.swift
//  Gloth
//
//  Created by Chris Sessions on 2/5/22.
//

import Foundation

protocol Generator {
    static func any() -> Phrase
}

extension Generator {
    static func generate(_ count: Int) -> [Phrase] {
        var phrases = Set<Phrase>()
        while phrases.count < count {
            phrases.insert(any())
        }
        return Array(phrases).sorted()
    }

    static func any(_ phrases: Phrase...) -> Phrase {
        phrases.randomElement()!
    }

    static func phrase(_ words: Word...) -> Phrase {
        Phrase(words.filter {
            switch $0 {
            case .dObject:  return true
            case .iObject:  return true
            case .modifier: return Bool.random()
            case .prep:     return true
            case .verb:     return true
            case .determ:   return Bool.random()
            }
        })
    }
}

extension Array {
    var rnd: Element {
        randomElement()!
    }
}
