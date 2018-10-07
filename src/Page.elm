module Page exposing (Page(..), view)

import Css exposing (..)
import Html.Styled as HtmlStyled exposing (Html, div, h1, span, text)
import Html.Styled.Attributes exposing (css)
import Page.Category as Category
import Style as Style


type Page
    = Category


styleHeader : Style
styleHeader =
    Css.batch
        [ position relative
        , padding (px 6)
        , height (px 36)
        , backgroundColor (rgb 96 181 204)
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
