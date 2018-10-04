module MyLinks.CategoryList.Update exposing (..)

import MyLinks.Category.Model exposing (Category)
import MyLinks.CategoryList.Model exposing (..)

type Msg
    = Add Category
    | Delete String
    | Select String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Add category->
            let
                categories = category :: model.categories
            in
                ( { model | categories = categories }, Cmd.none)
        
        Delete name ->
            let
                categories = List.filter (\category -> category.name /= name) model.categories
            in
                ( { model | categories = categories }, Cmd.none )

        Select name ->
            let
                category = List.head (List.filter (\category -> category.name == name) model.categories)
            in
                ( { model | selectedCategory = category }, Cmd.none)