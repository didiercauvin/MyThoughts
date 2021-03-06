module Style exposing (addCss, bulma, content, create, tagline, title)

import Css exposing (..)
import Css.Global exposing (..)
import Html.Styled exposing (Html, node)
import Html.Styled.Attributes exposing (href, rel)


content : Style
content =
    Css.batch
        [ width (px 1060)
        , margin2 (px 0) auto
        , padding (px 30)
        , fontFamilies [ "Helvetica", "Arial", "serif" ]
        ]


title : Style
title =
    Css.batch
        [ color (rgb 255 255 255)
        , fontWeight normal
        , margin (px 0)
        ]


tagline : Style
tagline =
    Css.batch
        [ color (hex "eee")
        , position absolute
        , right (px 16)
        , top (px 0)
        , fontSize (px 24)
        , fontStyle italic
        ]


create : Style
create =
    Css.batch
        [ position absolute
        , right (px 16)
        , top (px 32)
        ]


addCss : String -> Html msg
addCss path =
    node "link" [ rel "stylesheet", href path ] []


bulma : Html msg
bulma =
    addCss "https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.2/css/bulma.min.css"
