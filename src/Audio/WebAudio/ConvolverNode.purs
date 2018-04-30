module Audio.WebAudio.ConvolverNode (setBuffer, normalize, isNormalized) where

-- | Convolver Node.  This is usually used to provide Reverb - for example
-- | by simulating the effect of hearing the sound being played in a hall
-- | (termed the impulse response).
-- | It achieves this by performing a Linear Convolution on a supplied
-- | AudioBuffer which represent the hall's acoustics.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/ConvolverNode.

import Prelude (Unit)
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioBuffer, ConvolverNode, AUDIO)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)

-- | Set the AudioBuffer of the impulse response.
foreign import setBuffer
  :: ∀ eff. AudioBuffer
  -> ConvolverNode
  -> (Eff (audio :: AUDIO | eff) Unit)

-- | If true, the impulse response will be scaled by an equal-power normalization
normalize :: ∀ eff. Boolean -> ConvolverNode -> (Eff (audio :: AUDIO | eff) Unit)
normalize l n = unsafeSetProp "normalize" n l

isNormalized :: ∀ eff. ConvolverNode -> (Eff (audio :: AUDIO | eff) Boolean)
isNormalized = unsafeGetProp "normalize"
