import Html exposing (Html, text, div)

type alias Model =
    { message : String

    }

type Msg =
    NoOp

init : (Model, Cmd Msg)
init =
    ({ message = "coucou"}, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)

bandeau : Html msg
bandeau =
    div [] 
        [ text "Un joli bandeau pour mon application!"

        ]

view : Model -> (Html Msg)
view model =
    div []
        [
            bandeau
        ,   div []
                [ text model.message

                ]
        ]

main =
    Html.program
    {   init = init
    ,   view = view
    ,   update = update
    ,   subscriptions = (\_ -> Sub.none)
    }