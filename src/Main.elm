import Html
import Html.Styled.Events exposing (onClick, onInput)
import Html.Styled as HtmlStyled exposing (input, div, h1, h2, text, toUnstyled, Html, span, button, a, node, header, footer, section, p)
import Html.Styled.Attributes exposing (id, css, href, rel, class, attribute, placeholder)
import Style
import Category.Model exposing (..)
import Category.Update
import Category.View

type alias Model =
    { categories : List Category
    , currentCategoryModel : Category.Model.Model
    , isPopUpActive : Bool
    }

type Msg 
    = TogglePopup
    | MsgForCategory Category.Update.Msg
    | AddCategory
    | CancelEditCategory
    | DeleteCategory String

init : (Model, Cmd Msg)
init =
    ({ categories = [], isPopUpActive = False, currentCategoryModel = Category.Model.emptyModel }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        TogglePopup ->
            ( { model | isPopUpActive = not model.isPopUpActive }, Cmd.none)

        MsgForCategory msg ->
            let
                (categoryModel, cmdMsg) =
                    Category.Update.update msg model.currentCategoryModel
            in
                ( { model | currentCategoryModel = categoryModel }, Cmd.map MsgForCategory cmdMsg )

        AddCategory ->
            ( { model | isPopUpActive = not model.isPopUpActive
                      , currentCategoryModel = Category.Model.emptyModel
                      , categories = model.currentCategoryModel.category :: model.categories  }, Cmd.none)

        CancelEditCategory ->
            ( { model | isPopUpActive = not model.isPopUpActive, currentCategoryModel = Category.Model.emptyModel }, Cmd.none)
              
        _ ->
            (model, Cmd.none)

bandeau : Html msg
bandeau =
    div [ css [ Style.mainHeader ] ] 
        [ h1 [ css [ Style.title ] ] [ text "MyThoughts" ]
        , span [ css [ Style.tagline ] ] [ text "Pour mettre de côté mes liens utiles" ]
        ]

subbandeau : Html Msg
subbandeau =
    div [ css [ Style.subheader ]]
        [  h2 [] [ text "Mes catégories" ]
        ,  span [ css [ Style.create ] ] [ a [ class "button is-primary is-rounded", onClick TogglePopup ] [ text "Créer" ] ]
        ]

categories : List Category -> Html Msg
categories categories =
    case List.length categories of
        0 ->
            div [ css [ Style.listCategories ] ] [ text "Liste désespéremment vide..." ]
        _ ->
            div [ css [ Style.listCategories ] ] (List.map renderCategory categories)

view : Model -> (Html Msg)
view model =
    div [ css [ Style.content ] ]
        [ Style.bulma 
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
    div [ class "categoryItem"  ] 
         [   Style.categoryItemButton   
         ,   Style.categoryItemOnHover 
         ,   a [ class "button is-link is-rounded", href category.name ]
                [ text (category.name ++ renderNumberLinks category.links) 
                ]
                  
         , a [ id "deleteCategory", class "delete is-small", onClick ( DeleteCategory category.name ) ] []
         ]

renderNumberLinks : List Link -> String
renderNumberLinks links =
     " (" ++ toString (List.length links) ++ ")"

renderModal : Model -> Html Msg
renderModal model =
    div [ class "modal is-active", attribute "aria-label" "Modal title" ]
        [ div [ class "modal-background", onClick TogglePopup ]
            []
        -- , Html.map MsgForCategory (Category.View.view { category = model.currentCategory, errors = [] } )
        , div [ class "modal-card" ]
        [ header [ class "modal-card-head" ]
            [ p [ class "modal-card-title" ]
                [ text "Nouvelle catégorie" ]
            , button [ class "delete", onClick CancelEditCategory, attribute "aria-label" "close" ]
                []
            ]
        , section [ class "modal-card-body" ]
            [ HtmlStyled.map MsgForCategory (Category.View.view model.currentCategoryModel) ]
        , footer [ class "modal-card-foot" ]
            [ button [ class "button is-link", attribute "aria-label" "rien", onClick AddCategory ]
                [ text "Valider" ]
            , button [ class "button", onClick CancelEditCategory, attribute "aria-label" "cancel" ]
                [ text "Annuler" ]
        ]
        ]]




main =
    Html.program
    {   init = init
    ,   view = view >> toUnstyled
    ,   update = update
    ,   subscriptions = (\_ -> Sub.none)
    }