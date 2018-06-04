module Audio.WebAudio.ConvolverNode (setBuffer, normalize, isNormalized) where

-- | Convolver Node.  This is usually used to provide Reverb - for example
-- | by simulating the effect of hearing the sound being played in a hall
-- | (termed the impulse response).
-- | It achieves this by performing a Linear Convolution on a supplied
-- | AudioBuffer which represent the hall's acoustics.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/ConvolverNode.

import Prelude (Unit)
import Effect (Effect)
import Audio.WebAudio.Types (AudioBuffer, ConvolverNode)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)

-- | Set the AudioBuffer of the impulse response.
foreign import setBuffer
  :: AudioBuffer
  -> ConvolverNode
  -> Effect Unit

-- | If true, the impulse response will be scaled by an equal-power normalization
normalize :: Boolean -> ConvolverNode -> Effect Unit
normalize l n = unsafeSetProp "normalize" n l

isNormalized :: ConvolverNode -> Effect Boolean
isNormalized = unsafeGetProp "normalize"
