module Utils exposing (Die(..), allDice, decodeDie, targetValueDieDecoder)

import Html.Events exposing (targetValue)
import Json.Decode


type Die
    = D4
    | D6
    | D8
    | D10
    | D12


allDice : List Die
allDice =
    [ D4, D6, D8, D10, D12 ]


decodeDie : String -> Json.Decode.Decoder Die
decodeDie val =
    case val of
        "D4" ->
            Json.Decode.succeed D4

        "D6" ->
            Json.Decode.succeed D6

        "D8" ->
            Json.Decode.succeed D8

        "D10" ->
            Json.Decode.succeed D10

        "D12" ->
            Json.Decode.succeed D12

        _ ->
            Json.Decode.fail ("Invalid Die: " ++ val)


targetValueDieDecoder : Json.Decode.Decoder Die
targetValueDieDecoder =
    targetValue |> Json.Decode.andThen decodeDie
