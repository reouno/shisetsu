module Facilities.AddNewFacility exposing (..)

import Html exposing (Html, button, div, input, table, tbody, td, text, textarea, thead, tr)
import Html.Attributes exposing (class, cols, rows, type_)
import Msgs exposing (Msg)

view : Html Msg
view =
    div [ class "m2" ]
        [ nav
        , addNewFacility
        ]

nav : Html Msg
nav =
    div []
        [ text "add new facility page"
        ]

addNewFacility : Html Msg
addNewFacility =
    div []
        [ fieldList ]

fieldList : Html Msg
fieldList =
    div []
        [ table []
            [ thead [] []
            , tbody []
                [ tr []
                    [ td [] [ text "Facility name" ]
                    , td [] [ input [ type_ "text" ] [] ]
                    ]
                , tr []
                    [ td [] [ text "Opening time" ]
                    , td [] [ input [ type_ "time" ] []
                            , text " - "
                            , input [ type_ "time" ] []
                            ]
                    ]
                , tr []
                    [ td [] [ text "Postal code (Zip code)" ]
                    , td [] [ input [ type_ "text" ] [] ]
                    ]
                , tr []
                    [ td [] [ text "Address" ]
                    , td [] [ input [ type_ "text" ] [] ]
                    ]
                , tr []
                    [ td [] [ text "web_site URL" ]
                    , td [] [ input [ type_ "url" ] [] ]
                    ]
                , tr []
                    [ td [] [ text "description" ]
                    , td [] [ textarea [ rows 10, cols 100 ] [] ]
                    ]
                ]
            ]
        , button [ class "btn btn-primary mb1 bg-blue" ] [ text "register" ]
        ]
