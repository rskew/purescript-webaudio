module Audio.WebAudio.AudioParam
  (setTargetAtTime, setValueAtTime, getValue, setValue
  , linearRampToValueAtTime, exponentialRampToValueAtTime, cancelScheduledValues
  ) where

-- | An Audio Param. This represents an audio-related parameter of a node
-- | which can either be set immediately or else sheduled to be set or changed
-- | at a later time according to a choice of different scheduling algorithms.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/AudioParam.

import Prelude (Unit)
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, AUDIO, Value, Seconds)

-- | set the value immediately.
foreign import setValue
  :: ∀ eff. Value -> AudioParam -> (Eff (audio :: AUDIO | eff) Unit)

-- | Schedule an instant change to the value at a precise time,
foreign import setValueAtTime
  :: ∀ eff. Value -> Seconds -> AudioParam -> (Eff (audio :: AUDIO | eff) Value)

-- | Schedule the start of a change to the value. The change starts at the time
-- | specified by the first time parameter and exponentially moves towards
-- | the value given by the target AudioParam. The second time parameter
-- | defines the exponential decay rate.
foreign import setTargetAtTime
  :: ∀ eff. Value -> Seconds -> Seconds -> AudioParam -> (Eff (audio :: AUDIO | eff) Value)

foreign import getValue
  :: ∀ eff. AudioParam -> (Eff (audio :: AUDIO | eff) Value)

-- | Schedule a gradual linear change in the value.
foreign import linearRampToValueAtTime
  :: ∀ eff. Value -> Seconds -> AudioParam -> (Eff (audio :: AUDIO | eff) Value)

-- | Schedule a gradual exponential change in the value.
foreign import exponentialRampToValueAtTime
  :: ∀ eff. Value -> Seconds -> AudioParam -> (Eff (audio :: AUDIO | eff) Value)

-- | Cancel all scheduled future changes to the audio param.
foreign import cancelScheduledValues
  :: ∀ eff. Value -> AudioParam -> (Eff (audio :: AUDIO | eff) Value)
