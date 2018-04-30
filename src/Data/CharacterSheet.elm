module Data.CharacterSheet exposing (Abilities, Ability(..), CharacterSheet, setName, setProfession, setAbility, getAbility, allAbilities)

import Utils exposing (Die(..))


type Ability
    = Agility
    | Smarts
    | Spirit
    | Strength
    | Vigor


allAbilities : List Ability
allAbilities =
    [ Agility, Smarts, Spirit, Strength, Vigor ]


type alias Abilities =
    { agility : Die
    , smarts : Die
    , spirit : Die
    , strength : Die
    , vigor : Die
    }


type alias CharacterSheet =
    { name : String
    , profession : String
    , abilities : Abilities
    }


setName : String -> CharacterSheet -> CharacterSheet
setName name characterSheet =
    { characterSheet | name = name }


setProfession : String -> CharacterSheet -> CharacterSheet
setProfession profession characterSheet =
    { characterSheet | profession = profession }


getAbility : Ability -> CharacterSheet -> Die
getAbility ability characterSheet =
    case ability of
        Agility ->
            characterSheet.abilities.agility

        Smarts ->
            characterSheet.abilities.smarts

        Spirit ->
            characterSheet.abilities.spirit

        Strength ->
            characterSheet.abilities.strength

        Vigor ->
            characterSheet.abilities.vigor


setAbility : Ability -> Die -> CharacterSheet -> CharacterSheet
setAbility ability die characterSheet =
    let
        oldAbilities =
            characterSheet.abilities

        newAbilities =
            case ability of
                Agility ->
                    { oldAbilities | agility = die }

                Smarts ->
                    { oldAbilities | smarts = die }

                Spirit ->
                    { oldAbilities | spirit = die }

                Strength ->
                    { oldAbilities | strength = die }

                Vigor ->
                    { oldAbilities | vigor = die }
    in
        { characterSheet | abilities = newAbilities }
