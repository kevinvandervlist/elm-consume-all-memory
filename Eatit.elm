module Lib.List exposing (..)

import Dict exposing (..)


-- The issue, the top 'just' case with cons does not work and cause the compiler
-- to consume all available memory -- it never finishes. It probably has something to do with
-- this item on github: https://github.com/elm-lang/elm-compiler/issues/1231 but I'm not sure


eatit : comparable -> v -> Dict comparable (List v) -> Dict comparable (List v)
eatit key value dict =
    let
        dval =
            get key dict
    in
        case dval of
            Nothing ->
                insert key [ value ] dict

            Just something ->
                -- So the line with (something :: value) causes the issue
                -- insert key (something :: value) dict
                -- but these to options are fine
                -- insert key (something ++ [value]) dict
                insert key (value :: something) dict



-- In order to understad what's going on I created this function which works fine


works : List a -> a -> List a
works list element =
    element :: list



-- But this doesn't and gives the type mismatch compiler error below.
-- Why isn't such an error thrown while compiling the 'eatit' function?


doesnt : List a -> a -> List a
doesnt list element =
    list :: element



-- -- TYPE MISMATCH ----------------------------------------------------- Eatit.elm
-- The type annotation for `doesnt` does not match its definition.
-- 28| doesnt : List a -> a -> List a
--              ^^^^^^^^^^^^^^^^^^^^^
-- The type annotation is saying:
--     List a -> a -> List a
-- But I am inferring that the definition has this type:
--     List a -> List (List a) -> List (List a)
