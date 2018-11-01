module Facilities.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Material.Card as Card
import Material.Color as Color
import Material.Elevation as Elevation
import Material.Grid exposing (grid, cell, offset, size, Device(..))
import Models.Facility exposing (Facility)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Routing exposing (facilityPath, newFacilityPath)
import Styles



view : WebData (List Facility) -> Html Msg
view response =
    div [ class "m2" ]
        [ nav
        , maybeList response
        ]

nav : Html Msg
nav =
    div []
        [ text "Facility list"
        , span [ class "right" ] [ newFacilityLink ]
        ]


maybeList : WebData (List Facility) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""
        RemoteData.Loading ->
            text "Loading..."
        RemoteData.Success facilities ->
            tile facilities
        RemoteData.Failure error ->
            text (toString error)

tile : List Facility -> Html Msg
tile facilities =
    grid [] ( List.map facilityCell facilities )

facilityCell : Facility -> Material.Grid.Cell Msg
facilityCell facility =
    cell [ size Phone 4, size Tablet 4, size Desktop 4
         , Color.background Styles.tileColor
         ]
        [ wrapWithFacilityLink (facilityCard facility) facility.id ]

facilityCard : Facility -> Html Msg
facilityCard facility =
    Card.view
        [ Elevation.e3
        --, Options.onClick (Msgs.GoToFacilitySinglePage facility.id)
        ]
        [ Card.title []
            [ Card.head [] [ text facility.name ] ]
        , Card.text [] [ text (facility.opening.open ++ " - " ++ facility.opening.close) ]
        ]

tile_ : List Facility -> Html Msg
tile_ facilities =
    grid []
        [ cell [ size All 4, Color.background Styles.tileColor ]
            [ h4 [] [ text "Cell 1" ] ]
        , cell [ offset All 2, size All 4 ]
            [ h4 [] [ text "Cell 2" ]
            , p [] [ text "this cell is offset by 2" ]
            ]
        , cell [ size All 6 ]
            [ h4 [] [ text "Cell 3" ]
            ]
        , cell [ size Tablet 6, size Desktop 12, size Phone 2 ]
            [ h4 [] [ text "Cell 4" ]
            , p []  [ text "Size varies with device" ]
            ]
        ]

newFacilityLink : Html Msg
newFacilityLink =
    a [ href  newFacilityPath, class "center p1 white bg-blue rounded" ]
        [ text "add new facility"]

wrapWithFacilityLink view facilityId =
    a [ href (facilityPath facilityId) ] [ view ]
