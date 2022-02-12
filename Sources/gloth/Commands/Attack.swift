//
//  Attack.swift
//  Gloth
//
//  Created by Chris Sessions on 2/5/22.
//

import Foundation

enum Attack: Generator {
    static func any() -> Phrase {
        any(
            phrase(
                .verb(attack.rnd),
                .determ("the"),
                .modifier(enemyMod.rnd),
                .dObject(enemy.rnd),
                .prep("with"),
                .determ("the"),
                .modifier(weaponMod.rnd),
                .iObject(weapon.rnd)
            ),
            phrase(
                .verb(attack.rnd),
                .dObject(anyone.rnd),
                .prep("with"),
                .determ("the"),
                .modifier(weaponMod.rnd),
                .iObject(weapon.rnd)
            )
        )
    }
}

// MARK: - Samples

extension Attack {
    static var attack: [String] {
        [
            "attack",
            "disembowel",
            "eviscerate",
            "execute",
            "hit",
            "kill",
            "pummel",
            "smash",
        ]
    }

    static var anyone: [String] {
        enemy + [
            "myself",
            "self",
            "me",
        ]
    }

    static var enemy: [String] {
        [
            "dragon",
            "fighter",
            "goblin",
            "half-orc",
            "imp",
            "kobald",
            "monster",
            "orc",
            "thief",
            "troll",
            "wizard",
        ]
    }

    static var enemyMod: [String] {
        [
            "angry",
            "annoying",
            "chortling",
            "condescending",
            "evil",
            "greedy",
            "impatient",
            "lustful",
            "maddening",
            "ostentatious",
            "proud",
            "shifty",
            "sinister",
            "slovenly",
            "vicious",
        ]
    }

    static var weapon: [String] {
        [
            "axe",
            "chainsaw",
            "crossbow",
            "dagger",
            "grenade",
            "hammer",
            "knife",
            "letter-opener",
            "mace",
            "machete",
            "morning-star",
            "salami",
            "spatula",
            "sword",
        ]
    }

    static var weaponMod: [String] {
        [
            "bloody",
            "chipped",
            "cursed",
            "glowing",
            "rusty",
            "shimmering",
            "spectral",
            "unholy",
        ]
    }
}
