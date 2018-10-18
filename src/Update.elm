module Update exposing (..)

import Models exposing (Model, Facility)
import Msgs exposing (Msg(..))
import RemoteData
import Routing exposing (parseLocation)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msgs.OnFetchFacilities response ->
            ( { model | facilities = response }, Cmd.none )
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

        --Msgs.ChangeOpeningTime facility ->
        --    --let
        --    --    updatedFacility = { facility | opening = openingTime }
        --    --in
        --    ( updateFacility model facility, Cmd.none)

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