module Commands.SearchFacilities exposing (..)

import Commands exposing (dbRoot, facilitiesDecoder)
import Data.FacilityTagMap exposing (FacilityTagMap)
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Models.Facility exposing (Facility, FacilityId)
import Models.FacilityTag exposing (FacilityTag, FacilityTagId)
import Msgs exposing (Msg)
import RemoteData

fetchFacilityPath : FacilityId -> String
fetchFacilityPath facilityId =
    dbRoot ++ "/facilities/" ++ facilityId

fetchFacilityTagPath : String -> String
fetchFacilityTagPath tag_ =
    dbRoot ++ "/facility_tags?tag_=" ++ tag_

searchFacilitiesByTagPath : FacilityTagId -> String
searchFacilitiesByTagPath tagId =
    dbRoot ++ "/facility_tag_maps?facility_tag_id=" ++ (toString tagId)

fetchFacilityTagCmd : String -> Cmd Msg
fetchFacilityTagCmd tag_ =
    fetchFacilityTagRequest tag_
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchFacilityTag

--fetchFacilityTagRequest : String -> Http.Request FacilityTag
fetchFacilityTagRequest tag_ =
    Http.get (fetchFacilityTagPath tag_) facilityTagsDecoder

searchFacilitiesByTagCmd : FacilityTagId -> Cmd Msg
searchFacilitiesByTagCmd tagId =
    searchFacilitiesByTagRequest tagId
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnSearchFacilitiesByTag

--searchFacilitiesByTagRequest : FacilityTagId -> Http.Request (List FacilityTagMap)
searchFacilitiesByTagRequest tagId =
    Http.get (searchFacilitiesByTagPath tagId) facilityTagMapsDecoder

fetchFacilitiesByIdCmd : List FacilityId -> Cmd Msg
fetchFacilitiesByIdCmd facilityIds =
    fetchFacilitiesByIdRequest facilityIds
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchFacilitiesById

--fetchFacilitiesByIdRequest : List FacilityId -> Http.Request (List Facility)
fetchFacilitiesByIdRequest facilityIds =
    let
        queries = List.map (\x -> "id=" ++ x) facilityIds
        queryStr = String.join "&&" queries
        requestUrl = dbRoot ++ "/facilities?" ++ queryStr
    in
        Http.get requestUrl facilitiesDecoder

facilityTagsDecoder : Decode.Decoder (List FacilityTag)
facilityTagsDecoder =
    Decode.list facilityTagDecoder

facilityTagDecoder : Decode.Decoder FacilityTag
facilityTagDecoder =
    decode FacilityTag
        |> required "id" Decode.int
        |> required "tag_" Decode.string

facilityTagMapsDecoder : Decode.Decoder (List FacilityTagMap)
facilityTagMapsDecoder =
    Decode.list facilityTagMapDecoder

facilityTagMapDecoder : Decode.Decoder FacilityTagMap
facilityTagMapDecoder =
    decode FacilityTagMap
        |> required "id" Decode.int
        |> required "facility_id" Decode.string
        |> required "facility_tag_id" Decode.int

--getFacilities : List (RemoteData.WebData Facility) -> List Facility
getFacilities responses =
    let
        getFacilities_ responses results =
            case responses of
                [] -> results
                [res] ->
                    case res of
                        RemoteData.NotAsked ->
                            results
                        RemoteData.Loading ->
                            results
                        RemoteData.Failure error ->
                            let _ = Debug.log "getFacilities_ failed:" error in
                            results
                        RemoteData.Success facility ->
                            facility :: results
                (res::ress) ->
                    case res of
                        RemoteData.NotAsked ->
                            getFacilities_ ress results
                        RemoteData.Loading ->
                            getFacilities_ ress results
                        RemoteData.Failure error ->
                            let _ = Debug.log "getFacilities_ failed:" error in
                            getFacilities_ ress results
                        RemoteData.Success facility ->
                            getFacilities_ ress (facility :: results)
    in
        getFacilities_ responses []
