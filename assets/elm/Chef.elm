module Chef exposing (..)

import Debug exposing (log)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as JsDecode
import Json.Encode as JsEncode
import Phoenix.Channel
import Phoenix.Push
import Phoenix.Socket


--flags


type alias Flags =
    { data : String }



-- model


type alias Model =
    { phxSocket : Phoenix.Socket.Socket Msg
    , orders : List Order
    , messages : List String
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
    , price : Int
    }


modelDecoder : JsDecode.Decoder (List Order)
modelDecoder =
    JsDecode.list orderDecoder


orderDecoder : JsDecode.Decoder Order
orderDecoder =
    JsDecode.map5
        Order
        (JsDecode.field "id" JsDecode.int)
        (JsDecode.field "waiter" JsDecode.string)
        (JsDecode.field "table" JsDecode.int)
        (JsDecode.field "status" JsDecode.string)
        (JsDecode.field "food_order" (JsDecode.list decodeFoodOrder))


decodeFoodOrder : JsDecode.Decoder FoodOrder
decodeFoodOrder =
    JsDecode.map4
        FoodOrder
        (JsDecode.field "food" JsDecode.string)
        (JsDecode.field "status" JsDecode.string)
        (JsDecode.field "quantity" JsDecode.int)
        (JsDecode.field "price" JsDecode.int)


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        valueDue =
            JsDecode.decodeString modelDecoder flags.data

        channel =
            Phoenix.Channel.init "kitchen:1"

        ( initSocket, phxCmd ) =
            Phoenix.Socket.init "ws://localhost:4000/socket/websocket"
                |> Phoenix.Socket.withDebug
                |> Phoenix.Socket.on "chef" "kitchen:1" ReceiveChatMessage
                |> Phoenix.Socket.join channel
    in
    case valueDue of
        Ok nuevos ->
            ( { orders =
                    nuevos
              , phxSocket = initSocket
              , messages = []
              }
            , Cmd.map PhoenixMsg phxCmd
            )

        Err msg ->
            ( { orders = [], phxSocket = Phoenix.Socket.init "", messages = [] }, Cmd.none )



-- update


type Msg
    = PhoenixMsg (Phoenix.Socket.Msg Msg)
    | SetMessage String
    | SendMessage
    | ReceiveChatMessage JsEncode.Value
    | HandleSendError JsEncode.Value


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PhoenixMsg msg ->
            let
                ( phxSocket, phxCmd ) =
                    Phoenix.Socket.update msg model.phxSocket
            in
            ( { model | phxSocket = phxSocket }
            , Cmd.map PhoenixMsg phxCmd
            )

        -- SetMessage message ->
        --     ( { model | messageInProgress = message }, Cmd.none )
        --
        SendMessage ->
            let
                payload =
                    JsEncode.object
                        [ ( "message", JsEncode.string "holi" )
                        ]

                phxPush =
                    Phoenix.Push.init "chef" "kitchen:1"
                        |> Phoenix.Push.withPayload payload
                        |> Phoenix.Push.onError HandleSendError

                -- |> Phoenix.Push.onOk ReceiveChatMessage
                ( phxSocket, phxCmd ) =
                    Phoenix.Socket.push phxPush model.phxSocket
            in
            ( { model
                | phxSocket = phxSocket
              }
            , Cmd.map PhoenixMsg phxCmd
            )

        --
        ReceiveChatMessage raw ->
            let
                example =
                    log "entro" raw

                messageDecoder =
                    JsDecode.field "message" JsDecode.string

                somePayload =
                    JsDecode.decodeValue messageDecoder raw
            in
            case somePayload of
                Ok payload ->
                    ( { model | messages = payload :: model.messages }
                    , Cmd.none
                    )

                Err error ->
                    ( { model | messages = "Failed to receive message" :: model.messages }, Cmd.none )

        --
        HandleSendError err ->
            let
                message =
                    "Failed to Send Message"
            in
            ( { model | messages = message :: model.messages }, Cmd.none )

        _ ->
            ( model, Cmd.none )



--view


view : Model -> Html Msg
view model =
    div []
        [ button
            [ class "btn btn-success"
            , onClick SendMessage
            ]
            [ text "Send Message" ]
        , allMessages model.messages
        , orderList model
        ]


allMessages : List String -> Html Msg
allMessages messages =
    List.map allMessage messages
        |> ul []


allMessage : String -> Html Msg
allMessage message =
    li [] [ text message ]


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
        , th [] [ text (toString food_order.price) ]
        ]



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Phoenix.Socket.listen model.phxSocket PhoenixMsg


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
