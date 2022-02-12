//
//  Go.swift
//  Gloth
//
//  Created by Chris Sessions on 2/5/22.
//

import Foundation

enum Go: Generator {
    static func any() -> Phrase {
        any(
            phrase(
                .verb(direction.rnd)
            ),
            phrase(
                .verb(go.rnd),
                .dObject(anywhere.rnd)
            ),
            phrase(
                .verb(go.rnd),
                .prep(toward.rnd),
                .determ("the"),
                .dObject(cardinal.rnd)
            ),
            phrase(
                .verb(climb.rnd),
                .prep(through.rnd),
                .determ("the"),
                .modifier(goMod.rnd),
                .dObject(climbThroughable.rnd)
            ),
            phrase(
                .verb(climb.rnd),
                .determ("the"),
                .modifier(goMod.rnd),
                .dObject(climbable.rnd)
            )
        )
    }
}

// MARK: - Samples

extension Go {
    static var anywhere: [String] {
        direction + [
            "in",
            "out",
        ]
    }

    static var cardinal: [String] {
        [
            "e",
            "east",
            "n",
            "ne",
            "north",
            "northeast",
            "northwest",
            "nw",
            "s",
            "se",
            "south",
            "southeast",
            "southwest",
            "sw",
            "w",
            "west",
        ]
    }

    static var climb: [String] {
        [
            "climb",
            "crawl",
            "scamper",
            "scurry",
        ]
    }

    static var climbable: [String] {
        [
            "chimney",
            "ladder",
            "stairs",
            "tree",
            "wall",
        ]
    }

    static var climbThroughable: [String] {
        [
            "hatch",
            "hole",
            "opening",
            "trapdoor",
            "window",
        ]
    }

    static var direction: [String] {
        cardinal + through
    }

    static var go: [String] {
        climb + [
            "enter",
            "exit",
            "go",
            "hurry",
            "move",
            "run",
            "sneak",
            "sprint",
            "walk",
        ]
    }

    static var goMod: [String] {
        [
            "creaking",
            "dark",
            "dusty",
            "slimy",
            "terrifying",
            "unfathomable",
        ]
    }

    static var through: [String] {
        [
            "beneath",
            "down",
            "from",
            "over",
            "through",
            "under",
            "up",
        ]
    }

    static var toward: [String] {
        [
            "to",
            "toward",
        ]
    }
}
