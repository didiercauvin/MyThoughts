module Page exposing (Page(..), view)

import Css exposing (..)
import Html.Styled as HtmlStyled exposing (div, Html, h1, text, span)
import Html.Styled.Attributes exposing (css)
import Style as Style
import Page.Category as Category

type Page
    = Category

styleHeader : Style
styleHeader =    
    Css.batch
        [   position relative
        ,   padding (px 6)
        ,   height (px 36)
        ,   backgroundColor (rgb 96 181 204)
        ]

view : Html msg -> Html msg
view content =
    div [ css [ Style.content ] ]
        [ Style.bulma 
        , viewHeader
        , content
        ]

viewHeader : Html msg
viewHeader =
    div [ css [ styleHeader ] ] 
        [ h1 [ css [ Style.title ] ] [ text "Mes liens" ]
        , span [ css [ Style.tagline ] ] [ text "Pour mettre de côté mes liens utiles" ]
        ]
