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
                -- Using ++ is fine.
                -- insert key (something ++ [value]) dict
                -- insert key (something :: value) dict
                insert key (value :: something) dict
