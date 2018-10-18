module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (FacilityId, Facility, Opening)
import RemoteData

fetchFacilities : Cmd Msg
fetchFacilities =
    Http.get fetchFacilitiesUrl facilitiesDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchFacilities

fetchFacilitiesUrl : String
fetchFacilitiesUrl =
    "http://localhost:4000/facilities"

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
