module MyLinks.CategoryList.Model exposing (..)

import MyLinks.Category.Model exposing (..)

type alias Model = 
    {   categories : List Category
    ,   selectedCategory : Maybe Category
    }

emptyModel : Model
emptyModel = 
    {   categories = []
    ,   selectedCategory = Nothing
    }