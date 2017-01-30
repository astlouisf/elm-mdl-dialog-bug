module Main exposing (..)

import Html exposing (Html, div, text, p, program)
import Material
import Material.Button as Button
import Material.Options as Options
import Material.Scheme as Scheme
import Material.Dialog as Dialog


-- MODEL


type alias Model =
    { ints : List Int, dialogInt : Int, mdl : Material.Model }


init : ( Model, Cmd Msg )
init =
    ( { ints = [ 10, 20, 30, 40, 50, 60, 70 ], dialogInt = 0, mdl = Material.model }, Cmd.none )
--


-- MESSAGES


type Msg
    = Log Int
    | UpdateDialogInt Int
    | Mdl (Material.Msg Msg)



--VIEW


element : Model -> Html Msg
element model =
    -- let
    --     check =
    --         Debug.log "int" int
    -- in
    Dialog.view
        []
        [ Dialog.title [] [ text "Greetings" ]
        , Dialog.content []
            [ p [] [ text "What is this insanity?" ]
            , p [] [ text (toString model.dialogInt) ]
            ]
        , Dialog.actions []
            [ Button.render Mdl
                [ 1 ]
                model.mdl
                [ Dialog.closeOn "click" ]
                [ text "Close" ]
            ]
        ]


view : Model -> Html Msg
view model =
    div []
        ((element
            model
         )
            :: (List.map (\b -> button b model) model.ints)
        )
        |> Scheme.top


button : Int -> Model -> Html Msg
button int model =
    div []
        [ Button.render
            Mdl
            [ int ]
            model.mdl
            [ Button.raised
            , Button.ripple
            , Options.onClick (UpdateDialogInt int)
            , Dialog.openOn "click"
            ]
            [ text (toString int) ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Log int ->
            let
                check =
                    Debug.log "int" int
            in
                model ! []

        UpdateDialogInt int ->
            { model | dialogInt = int } ! []

        Mdl msg_ ->
            let
                check =
                    Debug.log "msg" msg_
            in
                Material.update Mdl msg_ model



-- MAIN


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
