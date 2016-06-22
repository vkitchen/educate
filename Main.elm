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
    { init = init 1
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
  { pageId : Int
  , lesson : String
  , code : String
  , output : String
  }

init topic =
  ( Model topic "Loading..." "" ""
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
  | FetchSucceed (String, String)
  | FetchFail Http.Error
  | Prompt String

update action model =
  case action of
    NoOp ->
      (model, Cmd.none)

    Tabbed ->
      (model, inserttab "null")

    NewContent content ->
      (Model model.pageId model.lesson content model.output, Cmd.none)

    RunCode ->
      (Model model.pageId model.lesson model.code "", runcode model.code)

    Output output ->
      (Model model.pageId model.lesson model.code (model.output ++ output)
        , Cmd.none)

    ClearOutput ->
      (Model model.pageId model.lesson model.code "", Cmd.none)

    PreviousPage ->
      (Model (model.pageId - 1) model.lesson model.code model.output
        , getPage (model.pageId - 1))

    NextPage ->
      (Model (model.pageId + 1) model.lesson model.code model.output
        , getPage (model.pageId + 1))

    FetchSucceed (lesson, code) ->
      (Model model.pageId lesson code "", Cmd.none)

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

decodeResponse : Json.Decoder (String, String)
decodeResponse =
  Json.object2 (,)
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
      [ button [ onClick PreviousPage ] [ text "<" ]
      , button [ onClick NextPage ] [ text ">" ]
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
