port module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown
import Http
import Json.Decode as Json exposing((:=))
import Task
import Nav
import RouteHash exposing (HashUpdate)
import RouteUrl exposing (UrlChange)
import RouteUrl.Builder as Builder exposing (Builder, builder, path, replacePath)
import String exposing (toInt)
import RouteUrl
import Navigation exposing (Location)

(=>) = (,)

main =
  RouteUrl.program
    { delta2url = delta2hash
    , location2messages = hash2messages
    , init = init 0
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
  | Set Int

update action model =
  case action of
    NoOp ->
      (model, Cmd.none)

    Tabbed ->
      (model, inserttab "null")

    NewContent code ->
      ({model | code = code}, Cmd.none)

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

    Set value ->
      ({model | pageId = value}, getPage value)

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
      "api/1/python/" ++ toString topic ++ ".json"
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
    [ Nav.nav
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
      [ h3 [ style [ "margin" => "0 auto" ]] [ text "tutorial.py" ]
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

-- ROUTING
-- Top Level
delta2hash : Model -> Model -> Maybe UrlChange
delta2hash previous current =
    -- Here, we're re-using the Builder-oriented code, but stuffing everything
    -- into the hash (rather than actually using the full URL).
    Maybe.map Builder.toHashChange <|
        delta2builder previous current

delta2builder : Model -> Model -> Maybe Builder
delta2builder previous current =
    builder
    |> replacePath [toString current.pageId]
    |> Just

--hash2messages : Location -> List Action
-- Top Level
hash2messages location =
    -- You can parse the `Location` in whatever way you want. I'm making
    -- a `Builder` and working from that, but I'm sure that's not the
    -- best way. There are links to a number of proper parsing packages
    -- in the README.
    builder2messages (Builder.fromHash location.href)

--builder2messages : Builder -> List Action
builder2messages builder =
    case path builder of
        first :: rest ->
            case toInt first of
                Ok value ->
                    [ Set value ]

                Err _ ->
                    -- If it wasn't an integer, then no action ... we could
                    -- show an error instead, of course.
                    []

        _ ->
            -- If nothing provided for this part of the URL, return empty list
            []


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
