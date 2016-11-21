module SimplePortProgram exposing (simpleProgram)

{-| Create simple programs for arbitrary JavaScript interoperation.

Deprecated as of Elm 0.18.0 thanks to Platform.program effectively doing the same thing.

For Elm 0.18.0, instead see our [Port Program Examples](https://github.com/Pilatch/elm-port-program-examples).

Great for beginners who want to quickly try out ports and get their
Elm code executing in any JavaScript environment.

Useful for large codebases too where you don't want to replace your
templating, data-binding, and/or HTML rendering, and you just want
the safety that Elm provides.

We have a [silly example](https://github.com/Pilatch/elm-simple-port-program/tree/master/examples/input-mangler)
that was specifically written to help new Elm users understand the
bare minimum of what's necessary to make Elm interoperate with JS.
It's the "Input Mangler," a NodeJS script that takes whatever the user
writes into standard input, sends that to Elm, which then sends back a
modified version of that text to Node again to be displayed on standard out.

[See how SimplePortProgram is used from Elm](https://github.com/Pilatch/elm-simple-port-program/blob/master/examples/input-mangler/Main.elm).

Then you can [see how it could be included in NodeJS](https://github.com/Pilatch/elm-simple-port-program/blob/master/examples/input-mangler/input-mangler.js).


# Start a Simple Program
@docs simpleProgram

-}

import Html.App exposing (program)
import Html exposing (text)


{-| Create the simplest program for interoperation with JavaScript in any setting,
whether a browser or NodeJS. All it requires is something that acts upon messages
coming in from JavaScript, and subscriptions from JavaScript that provide those
messages.
-}
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
