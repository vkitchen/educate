module Nav exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

(=>) = (,)

nav =
  div [ style ["display" => "flex", "align-items" => "center"
              , "background-color" => "#f5f5f5"
              ,"border-bottom" => "1px solid #ddd"]]
  [ a [ href "/", class "logo", style ["margin" => "5px"] ] [ text "VK" ]
  ]

-- DEAD CODE --

search =
    div [ style ["margin" => "0 auto"]]
      [ Html.form [ style ["border" => "1px solid #ddd"
                  , "background-color" => "#fff"
                  , "border-radius" => "3px"
                  ]] [
        div [ style ["display" => "inline", "border-right" => "1px solid #eee"
                    , "color" => "#767676", "padding" => "0 8px 0 8px"]]
          [ text "Py docs" ]
        ,input [ placeholder "Search", style ["display" => "inline"
                                            , "border" => "0"]] []
      ]]

tray =
    div [] [
      img [ src "/static/bell.png"
          , style ["height" => "20px"]] []
      , img [ src "/static/user.png"
          , style ["height" => "20px"]] []
    ]
