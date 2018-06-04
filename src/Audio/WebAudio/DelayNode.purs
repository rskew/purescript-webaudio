module Audio.WebAudio.DelayNode (delayTime) where

-- | Delay Node. This simply causes a delay between the arrival of an input
-- | data and its propagation to the output.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/DelayNode.

import Effect (Effect)
import Audio.WebAudio.Types (AudioParam, DelayNode)
import Audio.WebAudio.Utils (unsafeGetProp)

-- | The amount of delay to apply (in seconds).
delayTime :: DelayNode -> Effect AudioParam
delayTime = unsafeGetProp "delayTime"
