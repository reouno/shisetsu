module Routing exposing (..)

import Models.Facility exposing (FacilityId)
import Models.Route exposing (Route(..))
import Navigation exposing (Location)
import UrlParser exposing (map, oneOf, parseHash, Parser, s, string, top, (</>))

topPagePath : String
topPagePath = "/"

facilitiesPath : String
facilitiesPath =
    "#facilities"

facilityPath : FacilityId -> String
facilityPath facilityId =
    facilitiesPath ++ "/" ++ facilityId

facilityEditPath : FacilityId -> String
facilityEditPath facilityId =
    facilityPath facilityId ++ "/edit"

newFacilityPath : String
newFacilityPath =
    "#new-facility"

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map TopRoute top
        , map FacilityEditRoute (s "facilities" </> string </> s "edit")
        , map FacilityRoute (s "facilities" </> string)
        , map FacilitiesRoute (s "facilities")
        , map NewFacilityRoute (s "new-facility")
        , map SearchedByTagRoute (s "search" </> string)
        , map GetGeolocationRoute (s "geolocation")
        ]

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route
        Nothing ->
            NotFoundRoute

searchPath : String -> String
searchPath keyWord =
    "#search/" ++ keyWord
