module Audio.WebAudio.Utils
  ( createUint8Buffer, createFloat32Buffer, unsafeGetProp, unsafeSetProp) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.ArrayBuffer.Types (ByteLength, Uint8Array, Float32Array)
import Data.ArrayBuffer.ArrayBuffer (ARRAY_BUFFER, create) as ArrayBuffer
import Data.ArrayBuffer.DataView (whole)
import Data.ArrayBuffer.Typed (asUint8Array, asFloat32Array)

-- | set a named property an audio node
foreign import unsafeSetProp :: forall obj val eff. String -> obj -> val -> (Eff eff Unit)

-- | get a named property from an audio node
foreign import unsafeGetProp :: forall obj val eff. String -> obj -> (Eff eff val)

-- | create an unsigned 8-bit integer buffer for use with an analyser node
createUint8Buffer :: ∀ e. ByteLength -> Eff (arrayBuffer :: ArrayBuffer.ARRAY_BUFFER | e) Uint8Array
createUint8Buffer len =
  map (whole >>> asUint8Array) $ ArrayBuffer.create len

-- | create a Float 32 buffer for use with an analyser node
createFloat32Buffer :: ∀ e. ByteLength -> Eff (arrayBuffer :: ArrayBuffer.ARRAY_BUFFER | e) Float32Array
createFloat32Buffer len =
  map (whole >>> asFloat32Array) $ ArrayBuffer.create len
