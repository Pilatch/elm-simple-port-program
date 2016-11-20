module SimplePortProgram exposing (noViewProgram, simpleProgram)

import Html.App exposing (program)
import Html exposing (text)


simpleProgram :
    (msg -> Cmd msg)
    -> Sub msg
    -> Program Never
simpleProgram publish subscriptions =
    let
        update msg dummyModel =
            ( DummyModel, publish msg )

        modelBoundSubscriptions dummyModel =
            subscriptions
    in
        noViewProgram DummyModel update modelBoundSubscriptions


noViewProgram :
    model
    -> (msg -> model -> ( model, Cmd msg ))
    -> (model -> Sub msg)
    -> Program Never
noViewProgram model update subscriptions =
    Html.App.program
        { init = ( model, Cmd.none )
        , view = (\_ -> text "")
        , update = update
        , subscriptions = subscriptions
        }


type alias DummyModel =
    {}
