module Audio.WebAudio.GainNode (gain, setGain) where

-- | Gain Node.  This node sets the volume of the audio signal.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/GainNode.

import Prelude (Unit, (=<<))
import Effect (Effect)
import Audio.WebAudio.Types (AudioParam, GainNode)
import Audio.WebAudio.AudioParam (setValue)

-- | The amount of gain to apply.
foreign import gain
  :: GainNode -> Effect AudioParam

setGain :: Number -> GainNode -> Effect Unit
setGain num node =
  setValue num =<< gain node
