module Category.Update exposing (..)

import Validate exposing (Validator, ifBlank, validate)
import Category.Model exposing (..)

type Msg 
    = Edit String


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Edit name ->
            -- ({ model | category = { name = name, links = model.category.links }  }, Cmd.none)
            let
                currentCategory =
                    { name = name, links = model.category.links }
            in
                case validate modelValidator currentCategory of
                    [] ->
                        ({ model | category = currentCategory, errors = [] }, Cmd.none)

                    errors ->
                        ( { model | errors = errors }, Cmd.none )

--         CancelEditCategory ->
--             ( { model | currentCategory = Nothing, isPopUpActive = False }, Cmd.none )

--         DeleteCategory ->
--             (model, Cmd.none)


modelValidator : Validator String Category
modelValidator =
    Validate.all
        [ ifBlank .name "Veuillez renseigner un nom..."
        ]