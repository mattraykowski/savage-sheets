module Styles.Layout exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, value)


header : List (Html msg) -> Html msg
header =
    div [ css [ backgroundColor (rgb 0 0 0) ] ]
