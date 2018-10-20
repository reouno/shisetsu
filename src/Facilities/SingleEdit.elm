module Facilities.SingleEdit exposing (..)

import Html exposing (button, div, h1, Html, input, p, text, textarea)
import Html.Attributes exposing (class, cols, placeholder, name, rows, size, type_, value)
import Html.Events exposing (onClick, onInput)
import Models exposing (Facility)
import Msgs exposing (Msg)

view : Facility -> Html Msg
view model =
    div []
        [ nav model
        , viewFcl model
        ]

nav : Facility -> Html Msg
nav model =
    div []
        [ text "Editing..."]

viewFcl : Facility -> Html Msg
viewFcl model =
    div []
        [ h1 [] [ text model.name ]
        , editForm model
        ]

editForm : Facility -> Html Msg
editForm model =
    let _ = Debug.log "model:" model in
    div []
        [ div [ class "col col-8 px1"]
            [ p []
                [ text "Opening time: "
                , input [ type_ "time", value model.opening.open, onInput (Msgs.ChangeOpenTime model) ] []
                , text " - "
                , input [ type_ "time", value model.opening.close, onInput (Msgs.ChangeCloseTime model) ] []
                ]
            , p []
                [ text "Postal code (Zip code): "
                , input [ type_ "text", value model.postcode, onInput (Msgs.ChangePostCode model) ] []
                ]
            , p []
                [ text "Address: "
                , input [ type_ "text", size 100, value model.address, onInput (Msgs.ChangeAddress model) ] []
                ]
            , p []
                [ text "URL: "
                , input [ type_ "url", size 100, value model.web_site, onInput (Msgs.ChangeWebSite model) ] []
                ]
            , p []
                [ text "Description: "
                , textarea [ rows 10, cols 100, value model.description, onInput (Msgs.ChangeDescription model)] []
                ]
            , button [ class "btn btn-primary mb1 bg-blue"
                , onClick (Msgs.SaveUpdatedFacility model) ] [ text "Save"]
            ]
        ]

--send : Facility -> Html Msg
--send model =
--    let
--        message = Msgs.ChangeOpenTime
