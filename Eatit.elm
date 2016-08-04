module Lib.List exposing (..)

import Dict exposing (..)


upsert : comparable -> v -> Dict comparable (List v) -> Dict comparable (List v)
upsert key value dict =
    let
        dval =
            get key dict
    in
        case dval of
            Nothing ->
                insert key [ value ] dict

            Just something ->
                insert key (something :: value) dict
