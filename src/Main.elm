module Main exposing (Model(..), Msg(..), init, main, update, view)

import Browser
import Html.Styled as HtmlStyled exposing (Html, toUnstyled)
import Page
import Page.Category as Category


type Model
    = Category Category.Model


type Msg
    = CategoryMsg Category.Msg


init : ( Model, Cmd Msg )
init =
    ( Category Category.initModel, Cmd.none )


update : Msg -> (Model, Cmd Msg) -> ( Model, Cmd Msg )
update msg (model, _) =
    case ( msg, model ) of
        ( CategoryMsg categoryMsg, Category category ) ->
            let
                ( categoryModel, cmdMsg ) =
                    Category.update categoryMsg category
            in
            ( Category categoryModel, Cmd.map CategoryMsg cmdMsg )


view : (Model, Cmd Msg) -> Html Msg
view (model, _) =
    case model of
        Category category ->
            HtmlStyled.map CategoryMsg (Page.view (Category.view category))


main =
    Browser.sandbox
        { init = init
        , view = view >> toUnstyled
        , update = update
        -- , subscriptions = \_ -> Sub.none
        }
