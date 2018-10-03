module MyLinks.LinkList.Update exposing (..)

import MyLinks.LinkList.Model exposing (..)

type Msg =
    NoOp

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)
