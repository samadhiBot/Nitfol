//
//  Nitfol.swift
//  Nitfol
//
//  Created by Chris Sessions on 2/5/22.
//

import CoreML
import NaturalLanguage

public struct Nitfol {
    let tagScheme = NLTagScheme("Nitfol")

    let verbTag = NLTag("verb")
    let dObjectTag = NLTag("dObject")
    let prepTag = NLTag("prep")
    let skipTag = NLTag("skip")
    let modifierTag = NLTag("modifier")
    let iObjectTag = NLTag("iObject")

    let tagger: NLTagger

    public init() throws {
        let model = try NLModel(contentsOf: Bundle.module.url(
            forResource: "Nitfol",
            withExtension: "mlmodelc"
        )!)
        tagger = NLTagger(tagSchemes: [tagScheme])
        tagger.setModels([model], forTagScheme: tagScheme)
    }

    public func parse(_ string: String) -> Command {
        var verb: String?
        var directObject: String?
        var directObjectModifiers = [String]()
        var preposition: String?
        var indirectObject: String?
        var indirectObjectModifiers = [String]()

        tagger.string = string
        tagger.enumerateTags(
            in: string.startIndex..<string.endIndex,
            unit: .word,
            scheme: tagScheme,
            options: .omitWhitespace
        ) { (tag, tokenRange) -> Bool in
            let word = String(string[tokenRange]).lowercased()
            guard let tag = tag, tag != skipTag else {
                return true
            }
            switch tag {
            case verbTag:
                verb = word
            case dObjectTag:
                if directObject == nil {
                    directObject = word
                } else {
                    indirectObject = word
                }
            case prepTag:
                preposition = word
            case modifierTag:
                if directObject == nil {
                    directObjectModifiers.append(word)
                } else {
                    indirectObjectModifiers.append(word)
                }
            case iObjectTag:
                indirectObject = word
            default:
                break
            }
            return true
        }
        return .init(
            verb: verb,
            directObj: directObject,
            directObjMods: directObjectModifiers,
            preposition: preposition,
            indirectObj: indirectObject,
            indirectObjMods: indirectObjectModifiers
        )
    }
}
