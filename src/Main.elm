module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue, onClick)
import Data.CharacterSheet exposing (CharacterSheet, Ability(..), setAbility, getAbility)
import Utils exposing (Die(..), allDice, targetValueDieDecoder)


---- MODEL ----


type alias Model =
    { characterSheet : CharacterSheet
    }


blankCharacterSheet : CharacterSheet
blankCharacterSheet =
    { name = ""
    , profession = ""
    , abilities =
        { agility = D4
        , smarts = D4
        , spirit = D4
        , strength = D4
        , vigor = D4
        }
    }


init : ( Model, Cmd Msg )
init =
    ( { characterSheet = blankCharacterSheet
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = SelectAgility Die
    | SelectSmarts Die
    | SelectSpirit Die
    | SelectStrength Die
    | SelectVigor Die


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectAgility die ->
            ( { model | characterSheet = setAbility Agility die model.characterSheet }, Cmd.none )

        SelectSmarts die ->
            ( { model | characterSheet = setAbility Smarts die model.characterSheet }, Cmd.none )

        SelectSpirit die ->
            ( { model | characterSheet = setAbility Spirit die model.characterSheet }, Cmd.none )

        SelectStrength die ->
            ( { model | characterSheet = setAbility Strength die model.characterSheet }, Cmd.none )

        SelectVigor die ->
            ( { model | characterSheet = setAbility Vigor die model.characterSheet }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ section [ class "hero is-dark" ]
            [ div [ class "hero-body" ]
                [ div [ class "container" ]
                    [ h1 [ class "title" ] [ text "Savage Worlds - Deadlands" ]
                    , h2 [ class "subtitle" ] [ text "Character Sheet and generator." ]
                    ]
                ]
            ]
        , div [ class "container" ]
            [ nav [ class "columns" ]
                [ div [ class "column is-half" ]
                    [ csAttributeButtons model Agility SelectAgility
                    , csAttributeButtons model Smarts SelectSmarts
                    , csAttributeButtons model Spirit SelectSpirit
                    , csAttributeButtons model Strength SelectStrength
                    , csAttributeButtons model Vigor SelectVigor
                    ]
                , div [ class "column is-half" ]
                    [ input [ placeholder "Character name..." ] []
                    ]
                ]
            , div
                []
                [ text <| toString model ]
            ]
        ]


csAttributeButtons : Model -> Ability -> (Die -> Msg) -> Html Msg
csAttributeButtons model ability msg =
    let
        currentDie =
            getAbility ability model.characterSheet

        allButtons =
            List.map (dieButton currentDie msg) allDice
    in
        div [ class "level" ]
            [ span [ class "level-left" ] [ text <| toString ability ]
            , div [ class "level-right" ] allButtons
            ]


dieButton : Die -> (Die -> Msg) -> Die -> Html Msg
dieButton currentDie msg die =
    button [ class (isActive (currentDie == die) "level-item button is-small"), onClick (msg die) ] [ text <| toString die ]


isActive : Bool -> String -> String
isActive active class =
    if active then
        class ++ " is-active"
    else
        class



---- PROGRAM ----


main : Program Never Model Msg
main =
    program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
