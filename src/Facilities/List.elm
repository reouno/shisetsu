module Facilities.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href)
import Models exposing (Facility)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Routing exposing (facilityPath)



view : WebData (List Facility) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]

nav : Html Msg
nav =
    div []
        [ div [] [ text "施設一覧" ] ]

maybeList : WebData (List Facility) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""
        RemoteData.Loading ->
            text "Loading..."
        RemoteData.Success facilities ->
            list facilities
        RemoteData.Failure error ->
            text (toString error)

list : List Facility -> Html Msg
list facilities =
    div []
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Opening" ]
                    , th [] [ text "Address" ]
                    , th [] [ text "Postal code" ]
                    , th [] [ text "URL" ]
                    , th [] [ text "description" ]
                    ]
                ]
            , tbody [] (List.map facilityRow facilities)
            ]
        ]

facilityRow : Facility -> Html Msg
facilityRow facility =
    let
        openingTime = facility.opening
    in
        tr []
            [ td [] [ text facility.id ]
            , td [] [ editLink facility ]
            , td [] [ text (openingTime.open ++ " - " ++ openingTime.close) ]
            , td [] [ text facility.address ]
            , td [] [ text facility.postcode ]
            , td [] [ text facility.web_site ]
            , td [] [ text facility.description ]
            ]

editLink : Facility -> Html Msg
editLink facility =
    let
        editPath = facilityPath facility.id
    in
        a [ href editPath ]
            [ text facility.name ]
