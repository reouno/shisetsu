module Models exposing (..)

import Material
import Models.Facility exposing (Facility, FacilityId, Opening, emptyFacility)
import Models.FacilityTag exposing (FacilityTag, emptyFacilityTag)
import Models.Geolocation exposing (Geolocation, initialGeoLocation)
import Models.Route exposing (Route)
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
    , mdl : Material.Model
    , purposes: List String
    , facilityTag: FacilityTag
    , fetchedFacilities: WebData (List Facility)
    , geolocation: Geolocation
    }

initialModel : Route -> Model
initialModel route =
    { facilities = RemoteData.Loading
    , route = route
    , facilitySaveStatus = NotAsked
    , newFacility = emptyFacility
    , newFacilityRegisteringStatus = NotAsked
    , uuidSeed = initialSeed 1
    , mdl = Material.model
    , purposes = ["トイレ", "ゴミ箱", "駅", "観光", "三図河頭極楽東門蓮華台上阿弥陀坊太平埜山本実成院長福寿寺", "カフェ", "レストラン", "バー", "Tweebuffelsmeteenskootmorsdoodgeskietfontein", "居酒屋", "ジム", "ショッピング" ]
    , facilityTag = emptyFacilityTag
    , fetchedFacilities = RemoteData.Loading
    , geolocation = initialGeoLocation
    }

type RequestStatus
    = Success
    | Failure
    | NotAsked

type alias UuidSeed =
    { currentSeed: Seed
    , currentUuid: Maybe Uuid.Uuid
    }
