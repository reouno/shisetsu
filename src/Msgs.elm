module Msgs exposing (..)

import Http
import Models exposing (Facility, Opening)
import Navigation exposing (Location)
import RemoteData exposing (WebData)

type Msg
    = OnFetchFacilities (WebData (List Facility))
    | OnLocationChange Location
    | ChangeOpenTime Facility String
    | ChangeCloseTime Facility String
    | ChangeAddress Facility String
    | ChangePostCode Facility String
    | ChangeWebSite Facility String
    | ChangeDescription Facility String
    | SaveUpdatedFacility Facility
    | OnFacilitySave (Result Http.Error Facility)
