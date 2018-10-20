module Facilities.AddNewFacility exposing (..)

import Html exposing (Html, button, div, input, table, tbody, td, text, textarea, thead, tr)
import Html.Attributes exposing (class, cols, placeholder, rows, type_, value)
import Html.Events exposing (onClick, onInput)
import Msgs exposing (Msg)
import Models exposing (Facility)

view : Facility -> Html Msg
view newFacility =
    div [ class "m2" ]
        [ nav
        , addNewFacility newFacility
        ]

nav : Html Msg
nav =
    div []
        [ text "add new facility page"
        ]

addNewFacility : Facility -> Html Msg
addNewFacility newFacility =
    div []
        [ fieldList newFacility ]

fieldList : Facility -> Html Msg
fieldList newFacility =
    div []
        [ table []
            [ thead [] []
            , tbody []
                [ tr []
                    [ td [] [ text "Facility name" ]
                    , td [] [ input [ type_ "text", value newFacility.name, onInput Msgs.InputFacilityName ] [] ]
                    ]
                , tr []
                    [ td [] [ text "Opening time" ]
                    , td [] [ input [ type_ "time", value newFacility.opening.open, onInput Msgs.InputOpenTime ] []
                            , text " - "
                            , input [ type_ "time", value newFacility.opening.close, onInput Msgs.InputCloseTime ] []
                            ]
                    ]
                , tr []
                    [ td [] [ text "Postal code (Zip code)" ]
                    , td [] [ input [ type_ "text", value newFacility.postcode, onInput Msgs.InputPostCode ] [] ]
                    ]
                , tr []
                    [ td [] [ text "Address" ]
                    , td [] [ input [ type_ "text", value newFacility.address, onInput Msgs.InputAddress ] [] ]
                    ]
                , tr []
                    [ td [] [ text "web_site URL" ]
                    , td [] [ input [ type_ "url", value newFacility.web_site, onInput Msgs.InputWebSite ] [] ]
                    ]
                , tr []
                    [ td [] [ text "description" ]
                    , td [] [ textarea [ rows 10, cols 100, value newFacility.description, onInput Msgs.InputDescription ] [] ]
                    ]
                ]
            ]
        , button [ class "btn btn-primary mb1 bg-blue", onClick (Msgs.RegisterNewFacility newFacility) ] [ text "register" ]
        ]
