module Page.Category exposing (Model, Msg(..), editCategory, getNumberLinks, initModel, styleCategoryModalTitle, styleHoverCategoryModalTitle, styleItemButton, styleItemOnHover, styleListCategories, update, view, viewCategories, viewCategory, viewLink, viewLinks)

import Category exposing (Category, Link)
import Css exposing (..)
import Css.Global exposing (global, selector)
import Html.Styled as HtmlStyled exposing (Html, a, button, div, footer, header, input, p, section, span, text)
import Html.Styled.Attributes exposing (attribute, class, css, id, placeholder, value)
import Html.Styled.Events exposing (onClick, onInput)
import Style


type alias Model =
    { categories : List Category
    , newCategoryName : String
    , selectedCategory : Maybe Category
    , isOnCategoryHover : Bool
    , isPopUpActive : Bool
    , id : Int
    , errors : List String
    }


type Msg
    = Edit String
    | Append
    | Select Int
    | Delete Int
    | TogglePopup
    | ModifyTitle
    | Update String
    -- | Modify

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


styleCategoryModalTitle : Html msg
styleCategoryModalTitle =
    global
        [ selector "#categoryTitleEdit" [ display none ]
        , selector "#categoryTitle" [ display inlineBlock ]
        ]


styleHoverCategoryModalTitle : Html msg
styleHoverCategoryModalTitle =
    global
        [ selector ".modal-card:hover #categoryTitleEdit" [ display inlineBlock ]
        , selector ".modal-card:hover #categoryTitle" [ display none ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ text "page category"
        , input [ class "input", placeholder "Nom...", value model.newCategoryName, onInput Edit ] []
        , span [ css [ Style.create ] ] [ a [ class "button is-primary is-rounded", onClick Append ] [ text "Créer" ] ]
        , viewCategories model.categories
        , editCategory model
        ]


viewCategories : List Category -> Html Msg
viewCategories categories =
    if List.isEmpty categories then
        text "Liste désespéremment vide..."

    else
        div [ css [ styleListCategories ] ] (List.map viewCategory categories)


viewCategory : Category -> Html Msg
viewCategory category =
    div [ class "categoryItem" ]
        [ styleItemButton
        , styleItemOnHover
        , a [ class "button is-link is-rounded", onClick (Select category.id) ]
            [ text (category.name ++ getNumberLinks category.links)
            ]
        , a [ id "deleteCategory", class "delete is-small", onClick (Delete category.id) ] []
        ]


editCategory : Model -> Html Msg
editCategory model =
    case ( model.selectedCategory, model.isPopUpActive ) of
        ( Just category, True ) ->
            div [ class "modal is-active", attribute "aria-label" "Modal title" ]
                [ div [ class "modal-background", onClick TogglePopup ]
                    []
                , div [ class "modal-card" ]
                    [ header [ class "modal-card-head" ]
                        [ div [ class "modal-card-title" ]
                            [ div []
                                [ if model.isOnCategoryHover then
                                    div [] 
                                        [ span [ id "categoryTitleEdit" ] [ input [ class "input", placeholder "Nom...", value category.name, onInput Update ] [] ]
                                        , span [ css [ Style.create ] ] [ a [ class "button is-primary is-rounded" ] [ text "Modifier" ] ]
                                        ]
                                  else
                                    span [ id "categoryTitle", onClick ModifyTitle ] [ text category.name ]
                                ]
                            ]
                        , button [ class "delete", onClick TogglePopup, attribute "aria-label" "close" ]
                            []
                        ]
                    , section [ class "modal-card-body" ] [ viewLinks category ]
                    ]
                ]

        ( _, _ ) ->
            text ""


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
    span [] [ text link ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Edit name ->
            ( { model | newCategoryName = name }, Cmd.none )

        Update name ->
            case model.selectedCategory of
                Nothing ->
                    (model, Cmd.none)
            
                Just category ->
                    ( { model | selectedCategory = Just { category | name = name } }, Cmd.none)

        Append ->
            if String.isEmpty model.newCategoryName then
                ( model, Cmd.none )
            else
                let
                    categories =
                        Category model.id model.newCategoryName [] :: model.categories
                in
                ( { model
                    | categories = categories
                    , newCategoryName = ""
                    , id = model.id + 1
                  }
                , Cmd.none
                )

        Select id ->
            let
                category =
                    List.head (List.filter (\cat -> cat.id == id) model.categories)
            in
            ( { model
                | selectedCategory = category
                , isPopUpActive = True
              }
            , Cmd.none
            )

        Delete id ->
            let
                categories =
                    List.filter (\cat -> cat.id /= id) model.categories
            in
            ( { model | categories = categories }, Cmd.none )

        TogglePopup ->
            ( { model
                | isPopUpActive = not model.isPopUpActive
                , selectedCategory = Nothing
                , isOnCategoryHover = False
              }
            , Cmd.none
            )

        ModifyTitle ->
            ( { model | isOnCategoryHover = True }, Cmd.none )

        -- Modify ->
        --     let
        --         category =
        --             List.head (List.filter (\cat -> cat.name == name) model.categories)
        --     in
            


getNumberLinks : List Link -> String
getNumberLinks links =
    " (" ++ String.fromInt (List.length links) ++ ")"


initModel : Model
initModel =
    { categories = []
    , newCategoryName = ""
    , selectedCategory = Nothing
    , isOnCategoryHover = False
    , isPopUpActive = False
    , id = 0
    , errors = []
    }
