port module Main exposing (Model, Msg, update, view, subscriptions, init)
import Levels exposing (levels)
import Array exposing (get)
import Element exposing (..)
import Element.Keyed
import Element.Background as Background
import Element.Border as Border
import Element.Input exposing (slider, defaultThumb)
import Element.Font exposing (..)
import String exposing (fromInt, toInt)
import Browser
import Katex as K
import Browser.Events
import Json.Decode as D

port reloadMath : () -> Cmd a


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
    }

initialLevel = 0
numLevels = Array.length levels

type alias Model = { l:Int, k:Int }

init : () -> (Model, Cmd Msg)
init _ =
    (Model initialLevel 0, Cmd.none)


type Msg
    = ChangeSlider Int
    | Up
    | Down
    | Other


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ChangeSlider n ->
            ({model | l = n, k = model.k+1}, reloadMath ())
        Up ->
            if model.l + 2 > numLevels then (model, Cmd.none)
            else ({model | l = model.l+1, k= model.k+1}, reloadMath ())
        Down ->
            if model.l - 1 < 0 then (model, Cmd.none)
            else ({model | l = model.l-1, k= model.k+1}, reloadMath ())
        _ -> 
            (model, Cmd.none)
        


subscriptions : Model -> Sub Msg
subscriptions model = Browser.Events.onKeyDown keyDecoder

keyDecoder =
  D.map toDirection (D.field "key" D.string)

toDirection string =
  case string of
    "ArrowUp" -> Up
    "ArrowDown" -> Down
    _ -> Other


mySlider model = slider [
                    alignTop
                    , width (px 75)
                    , height fill 
                    , behindContent
                        (el
                            [ width (px 2)
                            , height fill
                            , centerX
                            , alignTop
                            , Background.color <| rgb 0.5 0.5 0.5
                            , Border.rounded 2
                            ]
                            none
                        )

                    ] 
                    { onChange = round >> ChangeSlider
                    , label = Element.Input.labelBelow [centerX, Element.Font.size 30] (text "Level ")
                    , min = 0
                    , max = toFloat <| numLevels - 1
                    , value = toFloat model.l
                    , thumb = defaultThumb
                    , step = Just 1
                    }


-- vgen n = 
--     if n < 30 then "V_{" ++ (fromInt n) ++ "}"
--     else if n < 60 then "V_{" ++ "\\omega" ++ "}" ++ if n == 30 then "" else ("+ " ++ fromInt (n-30))
--     else "V_{" ++ "\\omega^2" ++ "}" ++ if n == 60 then "" else ("+ " ++ fromInt (n-60))
footer = el [centerX, paddingEach {top=20,bottom=0,left=0,right=0}] (text "harryshahai@gmail.com")
    

view : Model -> Browser.Document Msg
view model =
    { title = "Von Neumann"
    , body =
        [layout [] 
            (column [padding 20,
                 height fill
                 , width fill
                --  , Background.color (rgb255 221 199 235)
                 , Background.gradient {angle=0, steps= [(rgb255 221 199 235), (rgb255 211 169 205)]}
                 , scrollbars
                ]
                [ 
                    el [Element.Font.size 40] (text "The Von Neumann Universe")
                    , row [padding 20, height (maximum 700 fill), width fill] [
                        mySlider model
                        , render model
                    ]
                    , footer
                ]
            )
        ]
      
    }

tex s = "\\("++ s ++"\\)"

render model =
    let indexed = get model.l levels in 
    case indexed of 
        Nothing -> text "Not Found"
        Just l -> 
            Element.Keyed.el [width fill, height fill] (fromInt model.k, 
                column [padding 20, spacing 5, height fill, width fill] [
                el [Element.Font.size 30, alignTop] (text (tex (l.name)))
                , el [Element.Font.size 30, alignTop] (text (tex ("|" ++ l.name ++ "|" ++ "=" ++ l.card)))
                , row [
                    width fill 
                    , height fill
                    , spacing 50
                    ]  [ wrappedRow [ spaceEvenly
                                , spacing 75
                                , scrollbarY
                                , padding 100
                                , Element.Font.size 30
                                , width (fillPortion 5)
                                , height (maximum 500 fill)
                                , Border.color <| rgb 0.6 0.6 0.6
                                , Border.rounded 20
                                , Border.width 5
                                , centerX, centerY
                                ] (List.map (\a -> el [centerX] (text (tex a))) l.contents)
                        , el [width (fillPortion 3), height (maximum 500 fill), scrollbarY, alignTop, Element.Font.size 30] 
                            (textColumn [spacing 30
                                , width fill
                                , height fill
                                ] (List.map (\a -> paragraph [] [text a]) l.info))
                        ]
                ]
            )
                
