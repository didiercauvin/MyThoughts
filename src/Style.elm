module Style exposing (..)

import Html.Styled exposing (Html, node)
import Html.Styled.Attributes exposing (href, rel)
import Css exposing (..)
import Css.Foreign exposing (..)

content : Style
content =
    Css.batch
        [   width (px 1060)
        ,   margin2 (px 0) auto
        ,   padding (px 30)
        ,   fontFamilies [ "Helvetica", "Arial", "serif" ]
        ]

mainHeader : Style
mainHeader =    
    Css.batch
        [   position relative
        ,   padding (px 6)
        ,   height (px 36)
        ,   backgroundColor (rgb 96 181 204)
        ]

subheader : Style
subheader =
    Css.batch
        [   position relative
        ,   padding (px 6)
        ,   height (px 36)
        ]

listCategories : Style
listCategories =
    Css.batch
        [ paddingTop (px 50)
        ]

title : Style
title =
    Css.batch
        [   color (rgb 255 255 255)
        ,   fontWeight normal
        ,   margin (px 0)
        ]

tagline : Style
tagline =
    Css.batch
        [   color (hex "eee")
        ,   position absolute
        ,   right (px 16)
        ,   top (px 0)
        ,   fontSize (px 24)
        ,   fontStyle italic
        ]

create : Style
create =
    Css.batch
        [   position absolute
        ,   right (px 16)
        ,   top (px 32)
        ]

addCss : String -> Html msg
addCss path =
    node "link" [ rel "stylesheet", href path] []

bulma : Html msg
bulma =
    addCss "https://cdnjs.cloudflare.com/ajax/libs/bulma/0.6.1/css/bulma.min.css"

categoryItemButton : Html msg
categoryItemButton =
    global [ selector "#deleteCategory" [ display none ] ]

categoryItemOnHover : Html msg
categoryItemOnHover =
    global [ selector ".categoryItem:hover #deleteCategory" [ display inlineBlock ] ] 
        
