module Main exposing (..)

import Commands exposing (fetchFacilities)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg(..))
import Navigation exposing (Location)
import Routing exposing (parseLocation)
import Update exposing (update)
import View exposing (view)


init : Location -> (Model, Cmd Msg)
init location =
    let
        currentRoute = parseLocation location
    in
        ( initialModel currentRoute, fetchFacilities )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
