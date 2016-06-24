module Nav exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

(=>) = (,)

nav =
  div [ style ["display" => "flex", "align-items" => "center"
              , "background-color" => "#f5f5f5"
              ,"border-bottom" => "1px solid #ddd"]]
  [ img [ src "/static/logo.png", style ["margin" => "5px"] ] []
  , search
  , tray
  ]

search =
    div [ style ["margin" => "0 auto"]]
      [ Html.form [ style ["border" => "1px solid #ddd"
                  , "background-color" => "#fff"
                  , "border-radius" => "3px"
                  ]] [
        div [ style ["display" => "inline", "border-right" => "1px solid #eee"
                    , "color" => "#767676", "padding" => "0 8px 0 8px"]]
          [ text "Lua docs" ]
        ,input [ placeholder "Search", style ["display" => "inline"
                                            , "border" => "0"]] []
      ]]

tray =
    div [] [
      img [ src "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Bell_alt_font_awesome.svg/200px-Bell_alt_font_awesome.svg.png"
          , style ["height" => "20px"]] []
      , img [ src "https://case.edu/medicine/admissions/media/school-of-medicine/admissions/classprofile.png"
          , style ["height" => "20px"]] []
    ]
