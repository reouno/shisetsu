module Models.Facility exposing (..)

type alias Facility =
    { id: FacilityId
    , name: String
    , opening: Opening
    , address: String
    , postcode: String
    , web_site: String
    , description: String
    }

type alias FacilityId =
    String

type alias Opening =
    { open: String
    , close: String
    }

emptyFacility : Facility
emptyFacility =
    { id = ""
    , name = ""
    , opening = emptyOpening
    , address = ""
    , postcode = ""
    , web_site = ""
    , description = ""
    }

emptyOpening : Opening
emptyOpening = { open = "", close = "" }
