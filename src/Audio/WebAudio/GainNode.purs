module Audio.WebAudio.GainNode (gain, setGain) where

-- | Gain Node.  This node sets the volume of the audio signal.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/GainNode.

import Prelude (Unit, (=<<))
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, GainNode, AUDIO)
import Audio.WebAudio.AudioParam (setValue)

-- | The amount of gain to apply.
foreign import gain
  :: forall eff. GainNode -> (Eff (audio :: AUDIO | eff) AudioParam)

setGain :: ∀ eff. Number -> GainNode -> (Eff (audio :: AUDIO | eff) Unit)
setGain num node =
  setValue num =<< gain node
