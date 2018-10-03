module MyLinks.CategoryList.Model exposing (..)

import MyLinks.Category.Model exposing (..)

type alias Model = List Category

emptyModel : Model
emptyModel =
    []