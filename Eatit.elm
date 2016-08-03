module Lib.List exposing (groupBy)

import Dict exposing (..)


groupBy : (a -> comparable) -> List a -> List (List a)
groupBy fn list =
    let
        indexed =
            List.map (\x -> ( fn x, x ))
                list

        dict =
            List.foldr upsert empty indexed

        _ =
            Debug.log
                "list:"
            <|
                values
                    dict
    in
        values dict


upsert : ( comparable, v ) -> Dict comparable (List v) -> Dict comparable (List v)
upsert tuple dict =
    let
        ( k, v ) =
            tuple
    in
        upsert' k v dict


upsert' : comparable -> v -> Dict comparable (List v) -> Dict comparable (List v)
upsert' key value dict =
    let
        dval =
            get key dict
    in
        case dval of
            Nothing ->
                insert key [ value ] dict

            Just something ->
                insert key (something :: value) dict
