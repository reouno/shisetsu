module Models.FacilityTag exposing (..)

type alias FacilityTagId = Int

type alias FacilityTag =
    { id: FacilityTagId
    , tag_: String
    }

emptyFacilityTag : FacilityTag
emptyFacilityTag =
    { id = -1
    , tag_ = "Nothing"
    }
