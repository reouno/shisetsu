module Models exposing (..)

import RemoteData exposing (WebData)

type alias Model =
    { facilities: WebData (List Facility)
    , route: Route
    }

initialModel : Route -> Model
initialModel route =
    { facilities = RemoteData.Loading
    , route = route
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
    | NotFoundRoute