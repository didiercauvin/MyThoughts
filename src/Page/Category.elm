module Page.Category exposing (..)

import Html.Styled.Events exposing (onClick, onInput)
import Html.Styled as HtmlStyled exposing (Html, text, input, div, a, span, p, button, header, section, footer)
import Html.Styled.Attributes exposing (css, class, placeholder, value, id, attribute)
import Css exposing (..)
import Css.Foreign exposing (global, selector)
import Category exposing (Category, Link)
import Style

type alias Model = 
    { categories : List Category
    , newCategoryName : String
    , selectedCategory : Maybe Category
    , isPopUpActive : Bool
    , errors : List String
    }

type Msg
    = Edit String
    | Append
    | Select String
    | Delete String
    | TogglePopup
    -- | Cancel

styleListCategories : Style
styleListCategories =
    Css.batch
        [ paddingTop (px 50)
        ]

styleItemButton : Html msg
styleItemButton =
    global [ selector "#deleteCategory" [ display none ] ]

styleItemOnHover : Html msg
styleItemOnHover =
    global [ selector ".categoryItem:hover #deleteCategory" [ display inlineBlock ] ] 

view : Model -> Html Msg
view model =
    div []
        [ text "page category"
        , input [ class "input", placeholder "Nom...", value model.newCategoryName, onInput Edit ] []
        , span [ css [ Style.create ] ] [ a [ class "button is-primary is-rounded", onClick Append ] [ text "Créer" ] ]
        , viewCategories model.categories
        , case (model.selectedCategory, model.isPopUpActive) of
            (Just category, True) ->
                editCategory category

            (_, _) ->
                text ""
        ]

viewCategories : List Category -> Html Msg
viewCategories categories =
    if List.isEmpty categories then
        text "Liste désespéremment vide..."
    else
        div [ css [ styleListCategories ] ] (List.map viewCategory categories)

viewCategory : Category -> (Html Msg)
viewCategory category =
    div [ class "categoryItem"  ] 
         [   styleItemButton   
         ,   styleItemOnHover 
         ,   a [ class "button is-link is-rounded", onClick (Select category.name) ]
                [ text (category.name ++ getNumberLinks category.links) 
                ]
                  
         , a [ id "deleteCategory", class "delete is-small", onClick ( Delete category.name ) ] []
         ]

editCategory : Category -> Html Msg
editCategory category =
    div [ class "modal is-active", attribute "aria-label" "Modal title" ]
        [ div [ class "modal-background", onClick TogglePopup ]
            []
        , div [ class "modal-card" ]
        [ header [ class "modal-card-head" ]
            [ p [ class "modal-card-title" ]
                [ text category.name
                ]
            , button [ class "delete", onClick TogglePopup, attribute "aria-label" "close" ]
                []
            ]
        , section [ class "modal-card-body" ]
            [ viewLinks category ]
        ]]

viewLinks : Category -> Html Msg
viewLinks category =
    if List.isEmpty category.links then
        text "Liste de liens désespéremment vide..."
    else
        div [] 
            [ span [] [ text "Liste des liens" ]
            , div [] (List.map viewLink category.links)
            ]
            

viewLink : Link -> Html Msg
viewLink link =
    span [][ text link ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Edit name ->
            ( {model | newCategoryName = name }, Cmd.none)
        Append ->
            if String.isEmpty model.newCategoryName then
                (model, Cmd.none)
            else
                let
                    categories = (Category model.newCategoryName []) :: model.categories
                in
                    ( { model | categories = categories
                              , newCategoryName = "" }, Cmd.none )
        Select name ->
            let
                category = List.head ( List.filter (\cat -> cat.name == name ) model.categories )
            in
                ( { model | selectedCategory = category
                          , isPopUpActive = True }, Cmd.none )
        
        Delete name ->
            let
                categories = List.filter (\cat -> cat.name /= name) model.categories
            in
                ( { model | categories = categories }, Cmd.none )
        
        TogglePopup ->
            ( { model | isPopUpActive = not model.isPopUpActive
                      , selectedCategory = Nothing }, Cmd.none )
            
getNumberLinks : List Link -> String
getNumberLinks links =
     " (" ++ toString (List.length links) ++ ")"

initModel : Model
initModel =
    { categories = []
    , newCategoryName = ""
    , selectedCategory = Nothing
    , isPopUpActive = False
    , errors = []
    }