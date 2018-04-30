module Audio.WebAudio.StereoPannerNode where

-- | Sterea Panner Node.  This allows panning between the left and right
-- | stereo channels.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/StereoPannerNode.

import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, StereoPannerNode, AUDIO)

-- | The amount of panning to employ.
foreign import pan
  :: forall eff. StereoPannerNode -> (Eff (audio :: AUDIO | eff) AudioParam)
