module Category.Model exposing (..)

type alias Model = 
    { category : Category
    , errors : List String
    }
      

type alias Category =
    { name : String
    , links : List Link
    }

type alias Link = String

emptyModel : Model
emptyModel =
    { category = { name = "", links = [] } 
    , errors = []
    }
