module Update exposing (..)

import Commands exposing (fetchFacilities, registerNewFacilityCmd, saveFacilityCmd)
import Models exposing (Model, Facility, RequestStatus(..))
import Msgs exposing (Msg(..))
import Random.Pcg exposing (step, initialSeed)
import RemoteData
import Routing exposing (parseLocation)
import Uuid

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msgs.OnFetchFacilities response ->
            ( { model | facilities = response }, Cmd.none )
        Msgs.GetRandomSeed randomSeed ->
            ( { model | uuidSeed = initialSeed randomSeed}, Cmd.none )
        Msgs.OnLocationChange location ->
            let
                newRoute = parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )
        Msgs.ChangeOpenTime facility time ->
            let
                updatedOpening = { open = time, close = facility.opening.close}
                updatedFacility = { facility | opening = updatedOpening }
            in
                ( updateFacility model updatedFacility, Cmd.none )
        Msgs.ChangeCloseTime facility time ->
            let
                updatedOpening = { open = facility.opening.open, close = time}
                updatedFacility = { facility | opening = updatedOpening }
            in
                ( updateFacility model updatedFacility, Cmd.none )
        Msgs.ChangeAddress facility newAddress ->
            let
                updatedFacility = { facility | address = newAddress }
            in
                ( updateFacility model updatedFacility, Cmd.none )
        Msgs.ChangePostCode facility newPostCode ->
            let
                updatedFacility = { facility | postcode = newPostCode }
            in
                ( updateFacility model updatedFacility, Cmd.none )
        Msgs.ChangeWebSite facility newWebSite ->
            let
                updatedFacility = { facility | web_site = newWebSite }
            in
                ( updateFacility model updatedFacility, Cmd.none )
        Msgs.ChangeDescription facility newDescription ->
            let
                updatedFacility = { facility | description = newDescription }
            in
                ( updateFacility model updatedFacility, Cmd.none )
        Msgs.SaveUpdatedFacility facility ->
            ( model, saveFacilityCmd facility)
        Msgs.OnFacilitySave (Ok facility) ->
            let
                modelSuccess = { model | facilitySaveStatus = Success }
            in
                ( updateFacility modelSuccess facility, Cmd.none )
        Msgs.OnFacilitySave (Err error) ->
            let
                modelFailure = { model | facilitySaveStatus = Failure }
            in
                ( modelFailure, Cmd.none )

-- for registering new facility
        Msgs.InputFacilityName name ->
            let
                facility = model.newFacility
                newFacility = { facility | name = name }
            in
                ( { model | newFacility = newFacility }, Cmd.none )
        Msgs.InputOpenTime time ->
            let
                facility = model.newFacility
                openingTime = facility.opening
                newOpeningTime = { openingTime | open = time }
                newFacility = { facility | opening = newOpeningTime }
            in
                ( { model | newFacility = newFacility }, Cmd.none )
        Msgs.InputCloseTime time ->
            let
                facility = model.newFacility
                openingTime = facility.opening
                newOpeningTime = { openingTime | close = time }
                newFacility = { facility | opening = newOpeningTime }
            in
                ( { model | newFacility = newFacility }, Cmd.none )
        Msgs.InputAddress address ->
            let
                facility = model.newFacility
                newFacility = { facility | address = address }
            in
                ( { model | newFacility = newFacility }, Cmd.none )
        Msgs.InputPostCode postcode ->
            let
                facility = model.newFacility
                newFacility = { facility | postcode = postcode }
            in
                ( { model | newFacility = newFacility }, Cmd.none )
        Msgs.InputWebSite web_site ->
            let
                facility = model.newFacility
                newFacility = { facility | web_site = web_site }
            in
                ( { model | newFacility = newFacility }, Cmd.none )
        Msgs.InputDescription description ->
            let
                facility = model.newFacility
                newFacility = { facility | description = description }
            in
                ( { model | newFacility = newFacility }, Cmd.none )
        Msgs.RegisterNewFacility facility ->
            let
                (newUuid, newSeed) =
                    step Uuid.uuidGenerator model.uuidSeed
                facility = model.newFacility
                newFacility = { facility | id = Uuid.toString newUuid }
            in
                ( { model | newFacility = newFacility, uuidSeed = newSeed }
                , registerNewFacilityCmd newFacility
                )
        Msgs.OnNewFacilityRegister (Ok facility) ->
            let _ = Debug.log "OnNewFacilityRegister Ok:" facility in
            ( { model | newFacility = Models.emptyFacility
                      , newFacilityRegisteringStatus = Success }
            , Cmd.none
            )
        Msgs.OnNewFacilityRegister (Err facility) ->
            let _ = Debug.log "OnNewFacilityRegister Err:" facility in
            ( { model | newFacilityRegisteringStatus = Failure }, Cmd.none )


updateFacility : Model -> Facility -> Model
updateFacility model updatedFacility =
    let
        replace currentFacility =
            if currentFacility.id == updatedFacility.id then
                updatedFacility
            else
                currentFacility
        updateFacilities facilities = List.map replace facilities
        updatedFacilities = RemoteData.map updateFacilities model.facilities
    in
        { model | facilities = updatedFacilities }
