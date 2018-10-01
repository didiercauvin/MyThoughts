import Html
import Html.Styled.Events exposing (onClick, onInput)
import Html.Styled as HtmlStyled exposing (input, div, h1, h2, text, toUnstyled, Html, span, button, a, node, header, footer, section, p)
import Html.Styled.Attributes exposing (id, css, href, rel, class, attribute, placeholder, value)
import Style
import Category.Model exposing (..)
import Category.Update
import Category.View
import CategoryList.Model exposing (..)
import CategoryList.Update exposing (..)
import CategoryList.View

type alias Model =
    { categories : CategoryList.Model.Model
    , newCategoryName : String
    , currentCategoryModel : Category.Model.Model
    , errors : List String
    , isPopUpActive : Bool
    , errors : List String
    }

type Msg 
    = TogglePopup
    | EditCategory String
    | AppendCategory
    | MsgForCategory Category.Update.Msg
    | MsgForCategoryList CategoryList.Update.Msg
    | CancelEditCategory

init : (Model, Cmd Msg)
init =
<<<<<<< HEAD
    ({ categories = []
     , isPopUpActive = False
     , currentCategoryModel = Category.Model.emptyModel 
     , errors = []
     }, Cmd.none)
=======
    ({ categories = [], newCategoryName = "", isPopUpActive = False, currentCategoryModel = Category.Model.emptyModel, errors = [] }, Cmd.none)
>>>>>>> tmp

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

        MsgForCategoryList msg ->
            let
                (categoryListModel, cmdMsg) =   
                    CategoryList.Update.update msg model.categories
            in
                ( { model | categories = categoryListModel
                          , isPopUpActive = case msg of
                                                Add _ ->
                                                     not model.isPopUpActive
                                                Delete _ ->
                                                    model.isPopUpActive
                          , currentCategoryModel = Category.Model.emptyModel 
                  } , Cmd.map MsgForCategoryList cmdMsg )

        CancelEditCategory ->
            ( { model | isPopUpActive = not model.isPopUpActive, currentCategoryModel = Category.Model.emptyModel }, Cmd.none)
        
        EditCategory name ->
            ({ model | newCategoryName = name }, Cmd.none)

        AppendCategory ->
            if String.isEmpty model.newCategoryName then
                (model, Cmd.none)
            else
                let
                    categories = model.categories
                    name = model.newCategoryName
                in
                    ({ model | categories = Category name [] :: categories
                                , newCategoryName = "" }, Cmd.none)

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
        ]

view : Model -> (Html Msg)
view model =
    div [ css [ Style.content ] ]
        [ Style.bulma 
        , bandeau
        , subbandeau
        , renderCategoryForm model
        , HtmlStyled.map MsgForCategoryList (CategoryList.View.view model.categories)
        , if model.isPopUpActive then
            renderModal model
          else
            text ""
        ]

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
            [ button [ class "button is-link", attribute "aria-label" "rien", onClick <| MsgForCategoryList <| Add model.currentCategoryModel.category ]
                [ text "Valider" ]
            , button [ class "button", onClick CancelEditCategory, attribute "aria-label" "cancel" ]
                [ text "Annuler" ]
        ]
        ]]

renderCategoryForm : Model -> Html Msg
renderCategoryForm model =
    div [ class "control" ] 
        [ input [ class "input", placeholder "Nom...", value model.newCategoryName, onInput EditCategory ] 
                [ text "" ]
        , span [ css [ Style.create ] ] [ a [ class "button is-primary is-rounded", onClick AppendCategory ] [ text "Créer" ] ]
        ]

main =
    Html.program
    {   init = init
    ,   view = view >> toUnstyled
    ,   update = update
    ,   subscriptions = (\_ -> Sub.none)
    }