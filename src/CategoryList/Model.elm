module CategoryList.Model exposing (..)

import Category.Model exposing (..)

type alias Model = List Category

emptyModel : Model
emptyModel =
    []