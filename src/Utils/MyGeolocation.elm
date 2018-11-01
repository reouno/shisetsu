module Utils.MyGeolocation exposing (..)

import Geolocation exposing (Error(..))

matchGeolocationError : Error -> String
matchGeolocationError error =
    case error of
        PermissionDenied error_ ->
            "Permission denied " ++ error_
        LocationUnavailable error_ ->
            "Location unavailable " ++ error_
        Timeout error_ ->
            "Timeout " ++ error_
