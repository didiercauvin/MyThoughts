module MyLinks.Link.Update exposing (..)

import MyLinks.Link.Model exposing (Model)

type Msg =
    NoOp

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)