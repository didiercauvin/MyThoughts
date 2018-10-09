module Page.Category exposing (..)

import Category exposing (Category, Link)
import Css exposing (..)
import Css.Global exposing (global, selector)
import Html.Styled as HtmlStyled exposing (Html, a, button, div, footer, header, input, p, section, span, text, label)
import Html.Styled.Attributes exposing (attribute, class, css, id, placeholder, value, href)
import Html.Styled.Events exposing (onClick, onInput)
import Style


type alias Model =
    { categories : List CategoryModel
    , newCategoryName : String
    -- , newLinkName : String
    , selectedCategory : Maybe CategoryModel
    , isOnCategoryHover : Bool
    , isPopUpActive : Bool
    , id : Int
    , errors : List String
    }

type alias CategoryModel =
    { category : Category
    , newLinkName : String
    }

type Msg
    = Edit String
    | Append
    -- | Select Int
    | Delete Int
    | Select CategoryModel
    -- | TogglePopup
    | AppendLink CategoryModel
    | EditLink String
    -- | ModifyTitle
    -- | Update String
    -- | Modify

-- | Cancel

styleListCategories : Style
styleListCategories =
    Css.batch
        [ paddingTop (px 50)
        ]

styleInputCategory : Style
styleInputCategory =
    Css.batch
        [width (px 50)]


styleItemButton : Html msg
styleItemButton =
    global [ selector "#deleteCategory" [ display none ] ]


styleItemOnHover : Html msg
styleItemOnHover =
    global [ selector ".categoryItem:hover #deleteCategory" [ display inlineBlock ] ]


styleCategorySection : Html msg
styleCategorySection =
    global
        [ selector "#category-title" [ display block ]
        , selector "#category-content" [ display none ]
        ]


styleToggleCategorySection : Html msg
styleToggleCategorySection =
    global
        [ selector ".section:hover #category-content" [ display block ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ text "page category"
        , viewCategoryCreation model
        , viewCategories model.categories
        -- , editCategory model
        ]


viewCategoryCreation : Model -> Html Msg
viewCategoryCreation model =
    div [ ]
        [ div [ class "field is-horizontal" ]
              [ div [ class "field-body" ]
                    [ div [ class "field" ]
                          [ div [ class "control"]
                                [ input [ class "input", placeholder "Nom...", value model.newCategoryName, onInput Edit ] [] ]
                          ]
                    , div [ class "field" ]
                          [ div [ class "control" ]
                                [ a [ class "button is-primary", onClick Append ] [ text "Créer" ] ]
                          ]
                    ]
              ]
        ]



viewCategories : List CategoryModel -> Html Msg
viewCategories categories =
    if List.isEmpty categories then
        text "Liste désespéremment vide..."
    else
        div [ css [ styleListCategories ] ] (List.map viewCategory categories)


viewCategory : CategoryModel -> Html Msg
viewCategory model =
    div []
        [ div [ class "section" ]
            [ styleCategorySection
        , styleToggleCategorySection
        , div [ class "container" ]
              [ div [ class "field", id "category-title"]
                    [ label [ class "label" ] [ text (model.category.name ++ getNumberLinks model.category.links)]
                    ]
              , div [id "category-content"]
                    [ div [ class "field is-horizontal" ]
                          [ div [ class "field-body" ]
                                [ div [ class "field" ]
                                      [ div [ class "control"]
                                            [ input [ class "input is-rounded", placeholder "Lien...", onClick (Select model), onInput EditLink, value model.newLinkName ] []
                                            ]
                                      ]
                                , div [ class "field" ]
                                    [ div [ class "control" ]
                                            [ a [ class "button is-primary is-rounded", onClick (AppendLink model) ] [ text "Ajouter" ] ]
                                    ]
                                ]
                          ]

                    , div [] [ viewLinks model.category ]
                    ]
                ]
            ]
        ]

    -- div [ class "categoryItem" ]
    --     [ styleItemButton
    --     , styleItemOnHover
    --     , label [ class "button is-link is-rounded", onClick (Select category.id) ]
    --         [ text (category.name ++ getNumberLinks category.links)
    --         ]
    --     , a [ id "deleteCategory", class "delete is-small", onClick (Delete category.id) ] []
    --     ]


-- editCategory : Model -> Html Msg
-- editCategory model =
--     case ( model.selectedCategory, model.isPopUpActive ) of
--         ( Just category, True ) ->
--             div [ class "modal is-active", attribute "aria-label" "Modal title" ]
--                 [ div [ class "modal-background", onClick TogglePopup ]
--                     []
--                 , div [ class "modal-card" ]
--                     [ header [ class "modal-card-head" ]
--                         [ div [ class "modal-card-title" ]
--                             [ div []
--                                 [ if model.isOnCategoryHover then
--                                     span [ id "categoryTitleEdit" ] [ input [ class "input", placeholder "Nom...", value category.name ] [] ]
--                                   else
--                                     span [ id "categoryTitle" ] [ text category.name ]
--                                 ]
--                             ]
--                         , button [ class "delete", onClick TogglePopup, attribute "aria-label" "close" ]
--                             []
--                         ]
--                     , section []
--                               [ input [ class "input", placeholder "Nom...", value model.newLinkName, onInput EditLink ] []
--                               , span [ css [ Style.create ] ] [ a [ class "button is-primary is-rounded", onClick AppendLink ] [ text "Créer" ] ]
--                               ]
--                     , section [ class "modal-card-body" ] [ viewLinks category ]
--                     ]
--                 ]

--         ( _, _ ) ->
--             text ""


viewLinks : Category -> Html Msg
viewLinks category =
    if List.isEmpty category.links then
        text "Liste de liens désespéremment vide..."
    else
        div []
            [ div [] (List.map viewLink category.links)
            ]


viewLink : Link -> Html Msg
viewLink link =
    div [] [ a [ href link ] [ text link ] ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Edit name ->
            ( { model | newCategoryName = name }, Cmd.none )

        Select categoryModel ->
            let
                category =
                    List.head (List.filter (\m -> m.category.id == categoryModel.category.id) model.categories)
            in
            ( { model
                | selectedCategory = category
                , isPopUpActive = True
              }
            , Cmd.none
            )

        EditLink name ->
            case model.selectedCategory of
                Nothing ->
                    ( model, Cmd.none )

                Just categoryModel ->
                    let
                        category = Just { categoryModel | newLinkName = name }

                        updateCategories m =
                            if m.category.id == categoryModel.category.id then
                                category
                            else
                                Just m

                        categories = List.filterMap updateCategories model.categories
                    in
                        ( { model | selectedCategory = category
                                  , categories = categories }, Cmd.none )

        -- Update name ->
        --     case model.selectedCategory of
        --         Nothing ->
        --             (model, Cmd.none)

        --         Just category ->
        --             ( { model | selectedCategory = Just { category | name = name } }, Cmd.none)

        Append ->
            if String.isEmpty model.newCategoryName then
                ( model, Cmd.none )
            else
                let
                    category = Category model.id model.newCategoryName []
                    categories =
                        CategoryModel category "" :: model.categories
                in
                ( { model
                    | categories = categories
                    , newCategoryName = ""
                    , selectedCategory = Nothing
                    , id = model.id + 1
                  }
                , Cmd.none
                )

        AppendLink categoryModel ->
            let
                links = categoryModel.newLinkName :: categoryModel.category.links
                categoryFromModel = List.head (List.filter (\m -> m.category.id == categoryModel.category.id) model.categories)


                updateCategories m =
                    if m.category.id == categoryModel.category.id then
                        let
                            cat = categoryModel.category
                        in
                            Just { m | category =  { cat | links = links}
                                     , newLinkName = ""}
                    else
                        Just m

                categories = List.filterMap updateCategories model.categories
            in
                ( { model | selectedCategory = Nothing
                          , categories = categories
                  } , Cmd.none )

        -- AppendLink ->
        --     case (model.selectedCategory, String.isEmpty model.newLinkName) of
        --         (Just category, True) ->
        --             let
        --                 links = model.newLinkName :: category.links

        --                 updateCategories c =
        --                     if c.id == category.id then
        --                         Just { category | links = links }
        --                     else
        --                         Just c

        --                 categories = List.filterMap updateCategories model.categories
        --             in
        --                 ( { model | selectedCategory = Just { category | links = links }
        --                             , categories = categories
        --                             , newLinkName = ""
        --                     } , Cmd.none )

        --         (_, _) ->
        --             (model, Cmd.none)

        -- Select id ->
        --     let
        --         category =
        --             List.head (List.filter (\cat -> cat.id == id) model.categories)
        --     in
        --     ( { model
        --         | selectedCategory = category
        --         , isPopUpActive = True
        --       }
        --     , Cmd.none
        --     )

        Delete id ->
            let
                categories =
                    List.filter (\m -> m.category.id /= id) model.categories
            in
            ( { model | categories = categories }, Cmd.none )

        -- TogglePopup ->
        --     ( { model
        --         | isPopUpActive = not model.isPopUpActive
        --         , selectedCategory = Nothing
        --         , isOnCategoryHover = False
        --       }
        --     , Cmd.none
        --     )

        -- ModifyTitle ->
        --     ( { model | isOnCategoryHover = True }, Cmd.none )

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
