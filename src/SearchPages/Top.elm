module SearchPages.Top exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Material.Button as Button
import Material.Options as Options
import Models exposing (Model)
import Msgs exposing (Msg)
import Routing exposing (searchPath)
import Styles

view : Model -> Html Msg
view model =
    div []
        [ nav model
        , top model
        ]

nav : Model -> Html Msg
nav model =
    div [] []

top : Model -> Html Msg
top model =
    div []
        [ h1 [class "h1 center" ] [ text "What to do?" ]
        , purposeCards model
        ]

purposeCards : Model -> Html Msg
purposeCards model =
    div [] ( List.map (purposeCard model) model.purposes)

purposeCard : Model -> String -> Html Msg
purposeCard model purpose =
    span [ class "inline-block m1" ]
        [ Button.render Msgs.Mdl [9,0,0,1] model.mdl
            [ Button.ripple
            , Button.plain
            , Button.flat
            , Options.onClick (Msgs.FetchFacilityTag purpose)
            , Button.link (searchPath purpose)
            ]
            [ text purpose ]
        ]
