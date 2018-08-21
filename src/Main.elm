import Css exposing (..)
import Html
import Html.Styled.Events exposing (onClick, onInput)
import Html.Styled exposing (input, div, h1, h2, text, toUnstyled, Html, span, button, a, node, header, footer, section, p)
import Html.Styled.Attributes exposing (css, href, rel, class, attribute, placeholder)

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

type alias Model =
    { categories : List Category
    , currentCategory : Maybe Category
    , isPopUpActive : Bool
    }

type alias Category =
    { name : String
    , links : List Link
    }

type alias Link = String

type Msg 
    = TogglePopup
    | EditCategoryName String
    | NewCategory
    | CancelEditCategory

init : (Model, Cmd Msg)
init =
    ({ categories = [], isPopUpActive = False, currentCategory = Nothing }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        TogglePopup ->
            ( { model | isPopUpActive = not model.isPopUpActive }, Cmd.none)
        EditCategoryName name ->
            ( { model | currentCategory = 
                            case model.currentCategory of
                                Just currentCategory ->
                                    Just { currentCategory | name = name }
                                Nothing ->
                                    Just { name = name, links = [] }           
            }, Cmd.none )

        NewCategory ->
            ( { model | categories = case model.currentCategory of
                                        Just currentCategory ->
                                            currentCategory :: model.categories
                                        Nothing ->
                                            model.categories
                      , currentCategory = Nothing
                      , isPopUpActive = False
             }, Cmd.none )

        CancelEditCategory ->
            ( { model | currentCategory = Nothing }, Cmd.none )

bandeau : Html msg
bandeau =
    div [ css [ mainHeader ] ] 
        [ h1 [ css [ title ] ] [ text "MyThoughts" ]
        , span [ css [ tagline ] ] [ text "Pour mettre de côté mes liens utiles" ]
        ]

subbandeau : Html Msg
subbandeau =
    div [ css [ subheader ]]
        [  h2 [] [ text "Mes catégories" ]
        ,  span [ css [ create ] ] [ button [ onClick TogglePopup ] [ text "Créer catégorie" ] ]
        ]

categories : List Category -> Html Msg
categories categories =
    case List.length categories of
        0 ->
            div [ css [ listCategories ] ] [ text "Liste désespéremment vide..." ]
        _ ->
            div [ css [ listCategories ] ] (List.map renderCategory categories)

view : Model -> (Html Msg)
view model =
    div [ css [ content ] ]
        [ bulma 
        , bandeau
        , subbandeau
        , categories model.categories
        , if model.isPopUpActive then
            renderModal model
          else
            text ""
        ]

renderCategory : Category -> (Html Msg)
renderCategory category =
    div [] 
         [ a [ href category.name ]
             [ text (category.name ++ renderNumberLinks category.links) 
             ]
         ]

renderNumberLinks : List Link -> String
renderNumberLinks links =
     " (" ++ toString (List.length links) ++ ")"

renderEditCategory : Maybe Category -> Html Msg
renderEditCategory category =
    let
        name = 
            case category of
                Just category ->
                    category.name
                Nothing ->
                    ""
    in
        div [ class "control" ] 
            [ input [ class "input", placeholder "Nom...", onInput EditCategoryName ] 
                    [ text name ]
            ]

renderModal : Model -> Html Msg
renderModal model =
    div [ class "modal is-active", attribute "aria-label" "Modal title" ]
        [ div [ class "modal-background", onClick TogglePopup ]
            []
        , div [ class "modal-card" ]
            [ header [ class "modal-card-head" ]
                [ p [ class "modal-card-title" ]
                    [ text "Nouvelle catégorie" ]
                , button [ class "delete", onClick TogglePopup, attribute "aria-label" "close" ]
                    []
                ]
            , section [ class "modal-card-body" ]
                [ renderEditCategory model.currentCategory ]
            , footer [ class "modal-card-foot" ]
                [ button [ class "button is-link", attribute "aria-label" "rien", onClick NewCategory ]
                    [ text "Valider" ]
                , button [ class "button", onClick TogglePopup, attribute "aria-label" "cancel" ]
                    [ text "Annuler" ]
                ]
            ]
        ]

main =
    Html.program
    {   init = init
    ,   view = view >> toUnstyled
    ,   update = update
    ,   subscriptions = (\_ -> Sub.none)
    }