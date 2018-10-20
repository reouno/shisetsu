module View exposing (..)

import Facilities.List
import Facilities.Single
import Facilities.SingleEdit
import Facilities.AddNewFacility
import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Models exposing (Model, Facility, FacilityId, RequestStatus(..))
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
        Models.NewFacilityRoute ->
            viewWithRequestStatus model.newFacilityRegisteringStatus Facilities.AddNewFacility.view model.newFacility
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
                        viewWithRequestStatus model.facilitySaveStatus Facilities.SingleEdit.view facility
                    Nothing ->
                        notFoundView "facility ID not found"
        RemoteData.Failure error ->
            text ( toString error )

viewWithRequestStatus : RequestStatus -> (Facility -> Html Msg) -> Facility -> Html Msg
viewWithRequestStatus status view facility =
    case status of
        Success ->
            div []
                [ view facility
                , p [ class "green" ] [ text "Request success!!"]
                ]
        Failure ->
            div []
                [ view facility
                , p [ class "orange" ] [ text "Requst failure."]
                ]
        NotAsked ->
            div []
                [ view facility
                , p [] []
                ]



notFoundView : String -> Html Msg
notFoundView s =
    div [] [ text ( "Page not found. " ++ s ) ]
