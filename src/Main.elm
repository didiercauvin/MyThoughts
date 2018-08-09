import Css exposing (..)
import Html
import Html.Styled exposing (div, h1, h2, text, toUnstyled, Html, span, button)
import Html.Styled.Attributes exposing (css)

content : Style
content =
    Css.batch
        [   width (px 1060)
        ,   margin2 (px 0) auto
        ,   padding (px 30)
        ,   fontFamilies [ "Helvetica", "Arial", "serif" ]
        ]

header : Style
header =    
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
        ,   top (px 12)
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

type alias Model =
    { message : String

    }

type Msg =
    NoOp

init : (Model, Cmd Msg)
init =
    ({ message = "hoho"}, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)

bandeau : Html msg
bandeau =
    div [ css [ header ] ] 
        [ h1 [ css [ title ] ] [ text "MyThoughts" ]
        , span [ css [ tagline ] ] [ text "Pour mettre de côté mes liens utiles" ]
        ]

subbandeau : Html msg
subbandeau =
    div [ css [ subheader ]]
        [  h2 [] [ text "Mes listes" ]
        ,  span [ css [ create ] ] [ button [] [ text "Créer liste" ] ]
        ]

view : Model -> (Html Msg)
view model =
    div [ css [ content ] ]
        [
            bandeau
        ,   subbandeau
        ]

main =
    Html.program
    {   init = init
    ,   view = view >> toUnstyled
    ,   update = update
    ,   subscriptions = (\_ -> Sub.none)
    }