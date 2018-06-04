module Audio.WebAudio.StereoPannerNode where

-- | Sterea Panner Node.  This allows panning between the left and right
-- | stereo channels.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/StereoPannerNode.

import Effect (Effect)
import Audio.WebAudio.Types (AudioParam, StereoPannerNode)

-- | The amount of panning to employ.
foreign import pan
  :: StereoPannerNode -> Effect AudioParam
