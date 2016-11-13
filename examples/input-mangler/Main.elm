port module Main exposing (..)

import SimplePortProgram exposing (simpleProgram)
import Mangle exposing (mangle)


port input : (MangleData -> msg) -> Sub msg


port output : String -> Cmd msg


type alias MangleData =
    { mangleOffset : Int, stringToMangle : String }


type Msg
    = MangleRequestedOn MangleData


publish : Msg -> Cmd Msg
publish msg =
    case msg of
        MangleRequestedOn data ->
            let
                mangledString =
                    mangle data.mangleOffset data.stringToMangle
            in
                output mangledString


subscription : Sub Msg
subscription =
    input MangleRequestedOn


main : Program Never
main =
    simpleProgram publish subscription
