module Category exposing (..)

type alias Category =
    { name : String
    , links : List Link
    }

type alias Link = String