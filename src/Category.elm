module Category exposing (Category, Link)


type alias Category =
    { id : Int
    , name : String
    , links : List Link
    }


type alias Link =
    String
