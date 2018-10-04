module MyLinks.Category.View exposing (..)

import Html.Styled.Events exposing (onInput)
import Html.Styled as HtmlStyled exposing (input, div, h1, h2, text, toUnstyled, Html, span, button, a, node, header, footer, section, p)
import Html.Styled.Attributes exposing (id, css, href, rel, class, attribute, placeholder, value)
import MyLinks.Category.Model exposing (..)
import MyLinks.Category.Update exposing (..)
import MyLinks.LinkList.View as LinkListView exposing (..)

view : Model -> Html Msg
view model =
    div [] 
        [ renderErrors model.errors
        , renderForm model.category
        , HtmlStyled.map MsgForLinkList (LinkListView.view model.category.links)
        ]

renderForm : Category -> Html Msg
renderForm category =
    div [ class "control" ] 
        [ text category.name
        -- ,   input [ class "input", placeholder "Nom...", onInput Edit ] 
        --           [ ]
        ]

renderErrors : List String -> Html Msg
renderErrors errors =
    div [] ( List.map renderError errors )

renderError : String -> Html Msg
renderError error =
    div [] [ text error]

