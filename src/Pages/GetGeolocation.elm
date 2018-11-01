module Pages.GetGeolocation exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Material.Button as Button
import Material.Options as Options
import Models exposing (Model)
import Models.Geolocation exposing (Geolocation)
import Msgs exposing (Msg)

view : Model -> Html Msg
view model =
    div [ class "m2" ]
        [ nav model
        , getGeolocationView model
        ]

nav : Model -> Html Msg
nav model =
    div [] [ h1 [] [ text "Where are you now?" ] ]

getGeolocationView : Model -> Html Msg
getGeolocationView model =
    div []
        [ getGeolocationBtn model
        , showGeolocation model.geolocation
        ]

getGeolocationBtn model =
    Button.render Msgs.Mdl [9,0,0,1] model.mdl
        [ Button.raised
        , Button.ripple
        , Options.onClick Msgs.GetGeolocation
        ]
        [ text "Get geolocation!" ]

showGeolocation : Geolocation -> Html Msg
showGeolocation geolocation =
    div []
        [ text ("(Latitude, Longitude) = (" ++ (toString geolocation.latitude) ++ ", " ++ (toString geolocation.longitude) ++ ")") ]
