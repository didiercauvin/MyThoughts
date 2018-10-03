module MyLinks.CategoryList.Model exposing (..)

import MyLinks.Category.Model exposing (..)

type alias Model = 
    {   categories : List Category
    ,   isPopUpActive : Bool
    }

emptyModel : Model
emptyModel = 
    {   categories = []
    ,   isPopUpActive = False
    }