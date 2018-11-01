module Models.Route exposing (..)

import Models.Facility exposing (FacilityId)

type Route
    = TopRoute
    | FacilitiesRoute
    | FacilityRoute FacilityId
    | FacilityEditRoute FacilityId
    | NewFacilityRoute
    | SearchedByTagRoute String
    | GetGeolocationRoute
    | NotFoundRoute
