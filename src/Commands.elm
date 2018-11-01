module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Msgs exposing (Msg)
import Models.Facility exposing (FacilityId, Facility, Opening)
import RemoteData

dbRoot : String
dbRoot = "http://localhost:4000"

fetchFacilities : Cmd Msg
fetchFacilities =
    Http.get fetchFacilitiesUrl facilitiesDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchFacilities

fetchFacilitiesUrl : String
fetchFacilitiesUrl =
    dbRoot ++ "/facilities"

facilitiesDecoder : Decode.Decoder (List Facility)
facilitiesDecoder =
    Decode.list facilityDecoder

facilityDecoder : Decode.Decoder Facility
facilityDecoder =
    decode Facility
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "opening" openingDecoder
        |> required "address" Decode.string
        |> required "postcode" Decode.string
        |> required "web_site" Decode.string
        |> required "description" Decode.string

openingDecoder : Decode.Decoder Opening
openingDecoder =
    decode Opening
        |> required "open" Decode.string
        |> required "close" Decode.string

facilityEncoder : Facility -> Encode.Value
facilityEncoder facility =
    let
        attributes =
            [ ("id", Encode.string facility.id)
            , ("name", Encode.string facility.name)
            , ("opening", openingEncoder facility.opening)
            , ("address", Encode.string facility.address)
            , ("postcode", Encode.string facility.postcode)
            , ("web_site", Encode.string facility.web_site)
            , ("description", Encode.string facility.description)
            ]
    in
        Encode.object attributes

openingEncoder : Opening -> Encode.Value
openingEncoder opening =
    let
        attributes =
            [ ("open", Encode.string opening.open)
            , ("close", Encode.string opening.close)
            ]
    in
        Encode.object attributes


saveFacilityCmd : Facility -> Cmd Msg
saveFacilityCmd facility =
    saveFacilityRequest facility
        |> Http.send Msgs.OnFacilitySave

saveFacilityRequest : Facility -> Http.Request Facility
saveFacilityRequest facility =
    Http.request
    { body = facilityEncoder facility |> Http.jsonBody
    , expect = Http.expectJson facilityDecoder
    , headers = []
    , method = "PATCH"
    , timeout = Nothing
    , url = saveFacilityUrl facility.id
    , withCredentials = False
    }

saveFacilityUrl : FacilityId -> String
saveFacilityUrl facilityId =
    fetchFacilitiesUrl ++ "/" ++ facilityId

registerNewFacilityCmd : Facility -> Cmd Msg
registerNewFacilityCmd facility =
    registerNewFacilityRequest facility
        |> Http.send Msgs.OnNewFacilityRegister

registerNewFacilityRequest : Facility -> Http.Request Facility
registerNewFacilityRequest facility =
    Http.request
        { body = facilityEncoder facility |> Http.jsonBody
        , expect = Http.expectJson facilityDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = fetchFacilitiesUrl
        , withCredentials = False
        }
