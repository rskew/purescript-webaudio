module Audio.WebAudio.DynamicsCompressorNode where

-- | Dynamics Compressor Node. This node lowers the loudest parts of an audio
-- | signal in order to prevent clipping.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/DynamicsCompressorNode.

import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, DynamicsCompressorNode, AUDIO)
import Audio.WebAudio.Utils (unsafeGetProp)

-- | The decibel value above which the compression will start taking effect.
foreign import threshold
  :: forall eff. DynamicsCompressorNode -> (Eff (audio :: AUDIO | eff) AudioParam)

-- | The range above the threshold where the curve smoothly transitions to the
-- | compressed portion.
foreign import knee
  :: forall eff. DynamicsCompressorNode -> (Eff (audio :: AUDIO | eff) AudioParam)

-- | The amount of change, in dB, needed in the input for a 1 dB change in the output.
foreign import ratio
  :: forall eff. DynamicsCompressorNode -> (Eff (audio :: AUDIO | eff) AudioParam)

-- | the amount of gain reduction currently applied by the compressor to the signal.
reduction :: ∀ eff. DynamicsCompressorNode  -> (Eff (audio :: AUDIO | eff) Number)
reduction n = unsafeGetProp "reduction" n

-- | The amount of time, in seconds, required to reduce the gain by 10 dB.
foreign import attack
  :: forall eff. DynamicsCompressorNode -> (Eff (audio :: AUDIO | eff) AudioParam)

-- | The amount of time, in seconds, required to increase the gain by 10 dB.
foreign import release
  :: forall eff. DynamicsCompressorNode -> (Eff (audio :: AUDIO | eff) AudioParam)
