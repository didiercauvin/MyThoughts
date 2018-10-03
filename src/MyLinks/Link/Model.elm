module MyLinks.Link.Model exposing (..)

type alias Model =
    {   link : Link
    ,   errors : List String
    }

type alias Link = String