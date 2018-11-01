module Data.FacilityTagMap exposing (..)

import Models.Facility exposing (FacilityId)
import Models.FacilityTag exposing (FacilityTagId)

type alias FacilityTagMapId = Int

-- need only for encode/decode json
type alias FacilityTagMap =
    { id: FacilityTagMapId
    , facility_id: FacilityId
    , facility_tag_id: FacilityTagId
    }
