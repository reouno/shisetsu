module Models.Geolocation exposing (..)

type alias Geolocation =
    { latitude: Float
    , longitude: Float
    , error: String
    }

initialGeoLocation : Geolocation
initialGeoLocation = Geolocation 0 0 ""

asErrorIn : Geolocation -> String -> Geolocation
asErrorIn model error =
    { model | error = error }
