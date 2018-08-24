module CategoryList.Update exposing (..)

import Category.Model exposing (Category)
import CategoryList.Model exposing (..)

type Msg
    = Add Category
    | Delete String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Add category->
            (category :: model, Cmd.none)
        
        Delete name ->
            ( (List.filter (\category -> category.name /= name) model) , Cmd.none )