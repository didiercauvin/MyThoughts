module MyLinks.Category.Model exposing (..)

import MyLinks.Link.Model exposing (Link)

type alias Model = 
    { category : Category
    , errors : List String
    }
      

type alias Category =
    { name : String
    , links : List Link
    }

emptyModel : Model
emptyModel =
    { category = { name = "", links = [] } 
    , errors = []
    }
