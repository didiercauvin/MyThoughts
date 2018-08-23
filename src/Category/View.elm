module Category.View exposing (..)

import Html.Styled.Events exposing (onInput)
import Html.Styled exposing (input, div, h1, h2, text, toUnstyled, Html, span, button, a, node, header, footer, section, p)
import Html.Styled.Attributes exposing (id, css, href, rel, class, attribute, placeholder, value)
import Category.Model exposing (..)
import Category.Update exposing (..)

view : Model -> Html Msg
view model =
    div [] 
        [ renderErrors model.errors
        , renderForm model.category
        ]

renderForm : Category -> Html Msg
renderForm category =
    div [ class "control" ] 
        [ input [ class "input", placeholder "Nom...", onInput Edit ] 
                [ text category.name ]
        ]

renderErrors : List String -> Html Msg
renderErrors errors =
    div [] ( List.map renderError errors )

renderError : String -> Html Msg
renderError error =
    div [] [ text error]

