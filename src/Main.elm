module Main exposing (..)

import Html
import Html.Styled as HtmlStyled exposing (toUnstyled, Html)
import Page
import Page.Category as Category
-- import Html.Styled.Events exposing (onClick, onInput)
-- import Html.Styled.Attributes exposing (id, css, href, rel, class, attribute, placeholder, value)
-- import Style as Style
-- import MyLinks.Category.Model as CategoryModel exposing (..)
-- import MyLinks.Category.Update as CategoryUpdate
-- import MyLinks.Category.View as CategoryView
-- import MyLinks.CategoryList.Model as CategoryListModel exposing (..)
-- import MyLinks.CategoryList.Update as CategoryListUpdate exposing (..)
-- import MyLinks.CategoryList.View as CategoryListView

-- type alias Model =
--     { categories : CategoryListModel.Model
--     , newCategory : Category
--     , currentCategoryModel : CategoryModel.Model
--     , errors : List String
--     , isPopUpActive : Bool
--     , errors : List String
--     }



-- type Msg 
--     = TogglePopup
--     | EditCategory String
--     | AppendCategory
--     | MsgForCategory CategoryUpdate.Msg
--     | MsgForCategoryList CategoryListUpdate.Msg
--     | CancelEditCategory

-- init : (Model, Cmd Msg)
-- init =
--     ({ categories = CategoryListModel.emptyModel
--      , newCategory = Category "" []
--      , isPopUpActive = False
--      , currentCategoryModel = CategoryModel.emptyModel 
--      , errors = []
--      }, Cmd.none)

type Model
    = Category Category.Model

type Msg
    = CategoryMsg Category.Msg

init : (Model, Cmd Msg)
init =
    (Category Category.initModel, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case (msg, model) of
        (CategoryMsg msg, Category category) ->
            let
                (categoryModel, cmdMsg) = Category.update msg category
            in
                ( Category categoryModel, Cmd.map CategoryMsg cmdMsg )

view : Model -> (Html Msg)
view model =
    case model of
        Category category ->
            HtmlStyled.map CategoryMsg (Page.view (Category.view category))

    -- case msg of
    --     TogglePopup ->
    --         ( { model | isPopUpActive = not model.isPopUpActive }, Cmd.none)

    --     MsgForCategory msg ->
    --         let
    --             (categoryModel, cmdMsg) =
    --                 CategoryUpdate.update msg model.currentCategoryModel
    --         in
    --             ( { model | currentCategoryModel = categoryModel }, Cmd.map MsgForCategory cmdMsg )

    --     MsgForCategoryList msg ->
    --         let
    --             (categoryListModel, cmdMsg) =   
    --                 CategoryListUpdate.update msg model.categories
    --         in
    --             ( { model | categories = categoryListModel
    --                       , isPopUpActive = case msg of
    --                                             Add _ ->
    --                                                  not model.isPopUpActive
    --                                             Delete _ ->
    --                                                 model.isPopUpActive
    --                                             Select _ ->
    --                                                 not model.isPopUpActive
    --                       , currentCategoryModel = case categoryListModel.selectedCategory of
    --                                                 Nothing ->
    --                                                     CategoryModel.emptyModel 
    --                                                 Just category ->
    --                                                     CategoryModel.Model category []
    --               } , Cmd.map MsgForCategoryList cmdMsg )

    --     CancelEditCategory ->
    --         ( { model | isPopUpActive = not model.isPopUpActive, currentCategoryModel = CategoryModel.emptyModel }, Cmd.none)
        
    --     EditCategory name ->
    --         let
    --             category = Category name []
    --         in
            
    --         ({ model | newCategory = category }, Cmd.none)

    --     AppendCategory ->
    --         if String.isEmpty model.newCategory.name then
    --             (model, Cmd.none)
    --         else
    --             let
    --                 categories = model.categories.categories
    --                 category = model.newCategory
    --             in
    --                 ({ model | categories = CategoryListModel.Model (category :: categories) Nothing
    --                             , newCategory = Category "" [] }, Cmd.none)

-- bandeau : Html msg
-- bandeau =
--     div [ css [ Style.mainHeader ] ] 
--         [ h1 [ css [ Style.title ] ] [ text "MyLinks" ]
--         , span [ css [ Style.tagline ] ] [ text "Pour mettre de côté mes liens utiles" ]
--         ]

-- subbandeau : Html Msg
-- subbandeau =
--     div [ css [ Style.subheader ]]
--         [  h2 [] [ text "Mes catégories" ]
--         ]


            

-- renderModal : Model -> Html Msg
-- renderModal model =
--     div [ class "modal is-active", attribute "aria-label" "Modal title" ]
--         [ div [ class "modal-background", onClick TogglePopup ]
--             []
--         -- , Html.map MsgForCategory (Category.View.view { category = model.currentCategory, errors = [] } )
--         , div [ class "modal-card" ]
--         [ header [ class "modal-card-head" ]
--             [ p [ class "modal-card-title" ]
--                 [ text "Fiche catégorie" ]
--             , button [ class "delete", onClick CancelEditCategory, attribute "aria-label" "close" ]
--                 []
--             ]
--         , section [ class "modal-card-body" ]
--             [ HtmlStyled.map MsgForCategory (CategoryView.view model.currentCategoryModel) ]
--         , footer [ class "modal-card-foot" ]
--             [ button [ class "button is-link", attribute "aria-label" "rien", onClick <| MsgForCategoryList <| Add model.currentCategoryModel.category ]
--                 [ text "Valider" ]
--             , button [ class "button", onClick CancelEditCategory, attribute "aria-label" "cancel" ]
--                 [ text "Annuler" ]
--         ]
--         ]]

-- renderCategoryForm : Model -> Html Msg
-- renderCategoryForm model =
--     div [ class "control" ] 
--         [ input [ class "input", placeholder "Nom...", value model.newCategory.name, onInput EditCategory ] 
--                 [ text "" ]
--         , span [ css [ Style.create ] ] [ a [ class "button is-primary is-rounded", onClick AppendCategory ] [ text "Créer" ] ]
--         ]

main =
    Html.program
    {   init = init
    ,   view = view >> toUnstyled
    ,   update = update
    ,   subscriptions = (\_ -> Sub.none)
    }