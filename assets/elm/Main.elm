module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


--model


type alias Model =
    { orders : List Order
    }


type alias Order =
    { id : Int
    , waiter : String
    , table : Int
    , status : String
    , foods : List Food
    }


type alias Food =
    { id : Int
    , name : String
    , quantity : Int
    , status : String
    }



--update
--view


main : Html html
main =
    div []
        [ p [] [ text "Holi" ] ]
