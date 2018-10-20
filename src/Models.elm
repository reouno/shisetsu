module Models exposing (..)

import Random.Pcg exposing (Seed, initialSeed, step)
import RemoteData exposing (WebData)
import Uuid

type alias Model =
    { facilities: WebData (List Facility)
    , route: Route
    , facilitySaveStatus: RequestStatus
    , newFacility: Facility
    , newFacilityRegisteringStatus: RequestStatus
    , uuidSeed: Seed
    }

initialModel : Route -> Model
initialModel route =
    { facilities = RemoteData.Loading
    , route = route
    , facilitySaveStatus = NotAsked
    , newFacility = emptyFacility
    , newFacilityRegisteringStatus = NotAsked
    , uuidSeed = initialSeed 1
    }

emptyFacility : Facility
emptyFacility =
    { id = ""
    , name = ""
    , opening = { open = "", close = "" }
    , address = ""
    , postcode = ""
    , web_site = ""
    , description = ""
    }

type alias FacilityId =
    String

type alias Facility =
    { id: FacilityId
    , name: String
    , opening: Opening
    , address: String
    , postcode: String
    , web_site: String
    , description: String
    }

type alias Opening =
    { open: String
    , close: String
    }

type Route
    = FacilitiesRoute
    | FacilityRoute FacilityId
    | FacilityEditRoute FacilityId
    | NewFacilityRoute
    | NotFoundRoute

type RequestStatus
    = Success
    | Failure
    | NotAsked

type alias UuidSeed =
    { currentSeed: Seed
    , currentUuid: Maybe Uuid.Uuid
    }
