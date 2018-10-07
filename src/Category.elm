module Category exposing (Category, Link)


type alias Category =
    { name : String
    , links : List Link
    }


type alias Link =
    String
