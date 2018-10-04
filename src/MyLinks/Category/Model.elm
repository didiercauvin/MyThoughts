module MyLinks.Category.Model exposing (..)

-- import MyLinks.Link.Model exposing (Link)
import MyLinks.LinkList.Model as LinkListModel exposing (..)

type alias Model = 
    { category : Category
    , errors : List String
    }
      

type alias Category =
    { name : String
    , links : LinkListModel.Model
    }

emptyModel : Model
emptyModel =
    { category = { name = "", links = [] } 
    , errors = []
    }
