module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode exposing (..)


--flags


type alias Flags =
    { data : String }



--model


type alias Model =
    { orders : List Order
    }


type alias Order =
    { id : Int
    , waiter : String
    , table : Int
    , status : String
    , food_order : List FoodOrder
    }


type alias FoodOrder =
    { food : String
    , status : String
    , quantity : Int
    }


modelDecoder : Decoder (List Order)
modelDecoder =
    Json.Decode.list orderDecoder


orderDecoder : Decoder Order
orderDecoder =
    map5
        Order
        (field "id" int)
        (field "waiter" string)
        (field "table" int)
        (field "status" string)
        (field "food_order" (Json.Decode.list decodeFoodOrder))


decodeFoodOrder : Decoder FoodOrder
decodeFoodOrder =
    map3
        FoodOrder
        (field "food" string)
        (field "status" string)
        (field "quantity" int)


initModel : Flags -> ( Model, Cmd Msg )
initModel flags =
    let
        valueDue =
            decodeString modelDecoder flags.data
    in
    case valueDue of
        Ok nuevos ->
            ( { orders =
                    nuevos
              }
            , Cmd.none
            )

        Err msg ->
            ( { orders = [] }, Cmd.none )



--update


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



--view


view : Model -> Html Msg
view model =
    div []
        [ orderList model
        ]


orderList : Model -> Html Msg
orderList model =
    model.orders
        |> List.map orderCard
        |> div []


orderCard : Order -> Html Msg
orderCard order =
    div [ class "card" ]
        [ div [ class "card-header" ]
            [ h5 [ class "mb-0" ]
                [ div [ class "title-card" ]
                    [ b [] [ text "N:" ]
                    , span [] [ text (toString order.id) ]
                    , text " "
                    , b [] [ text "Mozo:" ]
                    , span [] [ text (toString order.waiter) ]
                    , text " "
                    , b [] [ text "Mesa:" ]
                    , span [] [ text (toString order.table) ]
                    , text " "
                    , b [] [ text "Estado:" ]
                    , span [] [ text (toString order.status) ]
                    ]
                ]
            ]
        , div [ class "card-body" ]
            [ table [ class "table table-striped table-hover" ]
                [ thead []
                    [ tr []
                        [ th [] [ text "Plato" ]
                        , th [] [ text "Estado" ]
                        , th [] [ text "Cantidad" ]
                        , th [] [ text "Precio" ]
                        ]
                    ]
                , order.food_order |> foodOrderCards
                ]
            ]
        ]


foodOrderCards : List FoodOrder -> Html Msg
foodOrderCards food_orders =
    food_orders
        |> List.map foodOrderCard
        |> tbody []


foodOrderCard : FoodOrder -> Html Msg
foodOrderCard food_order =
    tr []
        [ th [] [ text (toString food_order.food) ]
        , th [] [ text (toString food_order.status) ]
        , th [] [ text (toString food_order.quantity) ]
        , th [] [ text "" ]
        ]


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = initModel
        , subscriptions = \_ -> Sub.none
        , view = view
        , update = update
        }
