module Routing exposing (..)

import Models exposing (FacilityId, Route(..))
import Navigation exposing (Location)
import UrlParser exposing (map, oneOf, parseHash, Parser, s, string, top, (</>))

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
        [ map FacilitiesRoute top
        , map FacilityEditRoute (s "facilities" </> string </> s "edit")
        , map FacilityRoute (s "facilities" </> string)
        , map FacilitiesRoute (s "facilities")
        , map NewFacilityRoute (s "new-facility")
        ]

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route
        Nothing ->
            NotFoundRoute
