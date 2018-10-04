module MyLinks.LinkList.View exposing (..)

import Html.Styled exposing (input, div, h1, h2, text, toUnstyled, Html, span, button, a, node, header, footer, section, p)
import Html.Styled.Attributes exposing (id, css, href, rel, class, attribute, placeholder, value)
import MyLinks.LinkList.Model as LinkListModel exposing (..)
import MyLinks.LinkList.Update exposing (..)
import MyLinks.Link.Model exposing (..)
import MyLinks.Style as Style

view : LinkListModel.Model -> Html Msg
view model =
    div []
        [
            text "Liens :"
        ,   case List.length model of
            0 ->
                div [ css [ Style.listCategories ] ] [ text "Liste désespéremment vide..." ]
            _ ->
                renderLinks model
        ]
    

renderLinks : LinkListModel.Model -> Html Msg
renderLinks links =
    div [] (List.map renderLink links)

renderLink : Link -> Html Msg
renderLink link =
    div [] [ text link ]