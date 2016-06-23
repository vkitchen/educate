port module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown
import Http
import Json.Decode as Json exposing((:=))
import Task
import Navigation

(=>) = (,)

main =
  Html.program
    { init = init 0
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


port runcode : String -> Cmd msg
port inserttab : String -> Cmd msg -- String is always empty

port output : (String -> msg) -> Sub msg
port updatecode : (String -> msg) -> Sub msg
port prompt : (String -> msg) -> Sub msg

-- MODEL
type alias Model =
  { totalItems : Int
  , pageId : Int
  , lesson : String
  , code : String
  , output : String
  }

init topic =
  ( Model 0 topic "Loading..." "" ""
  , getPage topic
  )

-- UPDATE
type Msg
  = NoOp
  | Tabbed
  | PreviousPage
  | RunCode
  | ClearOutput
  | Output String
  | NewContent String
  | NextPage
  | FetchSucceed (Int, String, String)
  | FetchFail Http.Error
  | Prompt String

update action model =
  case action of
    NoOp ->
      (model, Cmd.none)

    Tabbed ->
      (model, inserttab "null")

    NewContent lesson ->
      ({model | lesson = lesson}, Cmd.none)

    RunCode ->
      ({model | output = ""}, runcode model.code)

    Output output ->
      ({model | output = (model.output ++ output)}, Cmd.none)

    ClearOutput ->
      ({model | output = ""}, Cmd.none)

    PreviousPage ->
      ({model | pageId = (model.pageId - 1)}, getPage (model.pageId - 1))

    NextPage ->
      ({model | pageId = (model.pageId + 1)}, getPage (model.pageId + 1))

    FetchSucceed (totalItems, lesson, code) ->
      ({model | totalItems = totalItems, lesson = lesson, code = code}, Cmd.none)

    FetchFail _ ->
      (model, Cmd.none)

    Prompt _ ->
      (model, Cmd.none)

-- SUBSCRIPTIONS
subscriptions model =
  Sub.batch [
    output Output
    , updatecode NewContent
    , prompt Prompt
  ]

-- HTTP
getPage topic =
  let
    url =
      "/api/1/python/" ++ toString topic ++ ".json"
  in
    Task.perform FetchFail FetchSucceed (Http.get decodeResponse url)

--decodeResponse : Json.Decoder (String, String)
decodeResponse =
  Json.object3 (,,)
    ("total_items" := Json.int)
    ("lesson" := Json.string)
    ("code" := Json.string)

-- VIEW
view model =
  div
    [ style
      [ "height" => "100%", "display" => "flex"
      , "flex-direction" => "column" ]]
    [ Navigation.nav
    , windowbox model
    ]

windowbox model =
  div
    [ style
      [ "flex" => "1", "display" => "flex", "flex-direction" => "row"
      ,"margin" => "10px"]
    ]
    [ window
      [ button [ if model.pageId > 0 then onClick PreviousPage else disabled True ]
        [ text "<" ]
      , button [ if model.pageId < model.totalItems - 1 then onClick NextPage else disabled True]
        [ text ">" ]
      , h3 [ style [ "margin" => "0 auto" ]]
          [ text "Introduction to Programming" ]
      ]
      (tutorial model)
    , window
      [ h3 [ style [ "margin" => "0 auto" ]] [ text "tutorial.lua" ]
      , button [ onClick RunCode ] [ text "run" ]
      ]
      (editor model)
    , window
      [ h3 [ style [ "margin" => "0 auto" ]] [ text "Output" ]
      , button [ onClick ClearOutput ] [ text "clear" ]
      ]
      (pre [] [text model.output])
    ]

window menu content =
  div [ windowStyle ]
    [ div [ windowMenuStyle ] menu
    , content
    ]

editor model =
  textarea
    [ onInput NewContent
    , onTab Tabbed
    , style [ "flex" => "1" ]
    , value model.code
    ]
    []

tutorial model =
  div []
    [
    Markdown.toHtml [ style [ "margin" => "20px" ]] model.lesson
    ]

-- HELPERS
onTab action =
  let
    options = {preventDefault = True, stopPropagation = False}
    decoder =
      (Json.customDecoder keyCode (\k ->
        if k == 9
        then Ok action
        else Err "not handling that key"))
  in
    onWithOptions "keydown" options decoder

-- STYLES
windowMenuStyle =
  style
    [ "background-color" => "#f5f5f5"
    , "border-bottom" => "1px solid #ddd"
    , "display" => "flex", "align-items" => "center"
    , "height" => "30px"
    ]


windowStyle =
  style
    [ "flex" => "1"
    , "border" => "1px solid #ddd"
    , "border-radius" => "6px"
    , "margin" => "6px"
    , "display" => "flex"
    , "flex-direction" => "column"
    ]
