module MyLinks.Link.View exposing (..)

import Html.Styled exposing (input, div, h1, h2, text, toUnstyled, Html, span, button, a, node, header, footer, section, p)
-- import Html.Styled.Attributes exposing (id, css, href, rel, class, attribute, placeholder, value)
import MyLinks.Link.Model exposing (..)
import MyLinks.Link.Update exposing (..)


view : Model -> Html Msg
view model =
    div [] [ text model.link ]
