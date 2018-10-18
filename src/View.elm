module View exposing (..)

import Facilities.List
import Facilities.Single
import Facilities.SingleEdit
import Html exposing (Html, div, text)
import Models exposing (Model, FacilityId)
import Msgs exposing (Msg)
import RemoteData

view : Model -> Html Msg
view model =
    div []
        [ page model ]

page : Model -> Html Msg
page model =
    case model.route of
        Models.FacilitiesRoute ->
            Facilities.List.view model.facilities
        Models.FacilityRoute facilityId ->
            singlePage model facilityId
        Models.FacilityEditRoute facilityId ->
            singleEditPage model facilityId
        Models.NotFoundRoute ->
            notFoundView "url not found"

singlePage : Model -> FacilityId -> Html Msg
singlePage model facilityId =
    case model.facilities of
        RemoteData.NotAsked ->
            text "Data not asked"
        RemoteData.Loading ->
            text "Loading"
        RemoteData.Success response ->
            let
                maybeFacility =
                    List.head (List.filter (\facl -> facl.id == facilityId) response)
            in
                case maybeFacility of
                    Just facility ->
                        Facilities.Single.view facility
                    Nothing ->
                        notFoundView "facility ID not found"
        RemoteData.Failure error ->
            text ( toString error )

singleEditPage : Model -> FacilityId -> Html Msg
singleEditPage model facilityId =
    case model.facilities of
        RemoteData.NotAsked ->
            text "Data not asked"
        RemoteData.Loading ->
            text "Loading"
        RemoteData.Success response ->
            let
                maybeFacility =
                    List.head (List.filter (\facl -> facl.id == facilityId) response)
            in
                case maybeFacility of
                    Just facility ->
                        Facilities.SingleEdit.view facility
                    Nothing ->
                        notFoundView "facility ID not found"
        RemoteData.Failure error ->
            text ( toString error )


notFoundView : String -> Html Msg
notFoundView s =
    div [] [ text ( "Page not found. " ++ s ) ]
