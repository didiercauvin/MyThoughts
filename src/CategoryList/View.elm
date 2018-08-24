module CategoryList.View exposing (..)

import Html.Styled.Events exposing (onClick)
import Html.Styled exposing (input, div, h1, h2, text, toUnstyled, Html, span, button, a, node, header, footer, section, p)
import Html.Styled.Attributes exposing (id, css, href, rel, class, attribute, placeholder, value)
import Category.Model exposing (Category, Link)
import CategoryList.Model exposing (..)
import CategoryList.Update exposing (..)

import Style

view : Model -> Html Msg
view model =
    case List.length model of
        0 ->
            div [ css [ Style.listCategories ] ] [ text "Liste désespéremment vide..." ]
        _ ->
            div [ css [ Style.listCategories ] ] (List.map renderCategory model)

renderCategory : Category -> (Html Msg)
renderCategory category =
    div [ class "categoryItem"  ] 
         [   Style.categoryItemButton   
         ,   Style.categoryItemOnHover 
         ,   a [ class "button is-link is-rounded", href category.name ]
                [ text (category.name ++ renderNumberLinks category.links) 
                ]
                  
         , a [ id "deleteCategory", class "delete is-small", onClick ( Delete category.name ) ] []
         ]

renderNumberLinks : List Link -> String
renderNumberLinks links =
     " (" ++ toString (List.length links) ++ ")"