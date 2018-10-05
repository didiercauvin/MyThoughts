module Main exposing (..)

import Html
import Html.Styled as HtmlStyled exposing (toUnstyled, Html)
import Page
import Page.Category as Category

type Model
    = Category Category.Model

type Msg
    = CategoryMsg Category.Msg

init : (Model, Cmd Msg)
init =
    (Category Category.initModel, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case (msg, model) of
        (CategoryMsg msg, Category category) ->
            let
                (categoryModel, cmdMsg) = Category.update msg category
            in
                ( Category categoryModel, Cmd.map CategoryMsg cmdMsg )

view : Model -> (Html Msg)
view model =
    case model of
        Category category ->
            HtmlStyled.map CategoryMsg (Page.view (Category.view category))

main =
    Html.program
    {   init = init
    ,   view = view >> toUnstyled
    ,   update = update
    ,   subscriptions = (\_ -> Sub.none)
    }