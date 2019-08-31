{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "purescript-webaudio"
, dependencies =
    [ "aff"
    , "affjax"
    , "arraybuffer"
    , "arraybuffer-types"
    , "arrays"
    , "assert"
    , "console"
    , "effect"
    , "foldable-traversable"
    , "js-timers"
    , "lists"
    , "math"
    , "maybe"
    , "psci-support"
    , "refs"
    , "strings"
    , "tuples"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
