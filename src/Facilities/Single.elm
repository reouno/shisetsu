module Facilities.Single exposing (..)

import Html exposing (a, div, h1, Html, p, text)
import Html.Attributes exposing (class, href)
import Models.Facility exposing (Facility)
import Msgs exposing (Msg)
import Routing exposing (facilityEditPath)

view : Facility -> Html Msg
view model =
    div []
        [ nav model
        , viewFcl model
        ]

nav : Facility -> Html Msg
nav model =
    div []
        []

viewFcl : Facility -> Html Msg
viewFcl model =
    div []
        [ h1 [] [ text model.name ]
        , content model
        ]

editLink : Facility -> Html Msg
editLink facility =
    let
        editPath = facilityEditPath facility.id
    in
        a [ href editPath ]
            [ text "Edit" ]

content : Facility -> Html Msg
content model =
    div []
        [ div [ class "col col-8 px1"]
            [ p []
                [ text ("Opening time: " ++ model.opening.open ++ " - " ++ model.opening.close) ]
            , p []
                [ text model.description ]
            ]
        , div [ class "col col-4 px1 bg-silver"]
            [ p [ class "right-align" ]
                [ editLink model ]
            , p []
                [ text ("Postal code: " ++ model.postcode ) ]
            , p []
                [ text ("Address: " ++ model.address) ]
            , a [ href model.web_site ]
                [ text model.web_site ]
            ]
        ]
