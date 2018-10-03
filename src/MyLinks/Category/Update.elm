module MyLinks.Category.Update exposing (..)

import Validate exposing (Validator, ifBlank, validate)
import MyLinks.Category.Model exposing (..)

type Msg 
    = Edit String


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Edit name ->
            let
                currentCategory = Category name model.category.links
            in
                case validate modelValidator currentCategory of
                    [] ->
                        ({ model | category = currentCategory, errors = [] }, Cmd.none)

                    errors ->
                        ( { model | errors = errors }, Cmd.none )


modelValidator : Validator String Category
modelValidator =
    Validate.all
        [ ifBlank .name "Veuillez renseigner un nom..."
        ]