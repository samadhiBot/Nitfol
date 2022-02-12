//
//  Word.swift
//  Gloth
//
//  Created by Chris Sessions on 2/5/22.
//

import Foundation

enum Word: Hashable {
    var token: String {
        switch self {
        case .dObject(let word):  return word
        case .iObject(let word):  return word
        case .modifier(let word): return word
        case .prep(let word):     return word
        case .verb(let word):     return word
        case .determ(let word):   return word
        }
    }

    var label: String {
        switch self {
        case .dObject:  return "dObject"
        case .iObject:  return "iObject"
        case .modifier: return "modifier"
        case .prep:     return "prep"
        case .verb:     return "verb"
        case .determ:   return "skip"
        }
    }

    case dObject(String)
    case iObject(String)
    case modifier(String)
    case prep(String)
    case verb(String)
    case determ(String)
}
