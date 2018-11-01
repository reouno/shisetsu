module Msgs exposing (..)

import Data.FacilityTagMap exposing (FacilityTagMap)
import Geolocation as Geo
import Http
import Material
import Models.Facility exposing (Facility, FacilityId, Opening)
import Models.FacilityTag exposing (FacilityTag)
import Navigation exposing (Location)
import RemoteData exposing (WebData)

type Msg
    = GetRandomSeed Int
    | OnFetchFacilities (WebData (List Facility))
    | OnLocationChange Location
    | ChangeOpenTime Facility String
    | ChangeCloseTime Facility String
    | ChangeAddress Facility String
    | ChangePostCode Facility String
    | ChangeWebSite Facility String
    | ChangeDescription Facility String
    | SaveUpdatedFacility Facility
    | OnFacilitySave (Result Http.Error Facility)

-- for registering new facility
    | InputFacilityName String
    | InputOpenTime String
    | InputCloseTime String
    | InputAddress String
    | InputPostCode String
    | InputWebSite String
    | InputDescription String
    | RegisterNewFacility Facility
    | OnNewFacilityRegister (Result Http.Error Facility)

-- new features for Material Design Lite
    | Mdl (Material.Msg Msg)
    | GoToFacilitySinglePage FacilityId
    | FetchFacilityTag String
    | OnFetchFacilityTag (WebData (List FacilityTag))
    | OnSearchFacilitiesByTag (WebData (List FacilityTagMap))
    | OnFetchFacilitiesById (WebData (List Facility))

-- new features for use geolocation
    | GetGeolocation
    | OnGeolocationGet (Result Geo.Error Geo.Location)
    | Geolocation Geo.Location
    --| InitGeolocation (Geo.Result Geo.Error Geo.Location)
