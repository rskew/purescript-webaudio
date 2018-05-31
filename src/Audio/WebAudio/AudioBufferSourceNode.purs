module Audio.WebAudio.AudioBufferSourceNode
  ( StartOptions, defaultStartOptions, setBuffer, startBufferSource, stopBufferSource
  , loop, setLoop, loopStart, setLoopStart, loopEnd, setLoopEnd  ) where

-- | Audio Buffer Source Node.  This is an audio source consisting of in-memory
-- | audio data, stored in an AudioBuffer.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/AudioBufferSourceNode.

import Prelude

import Audio.WebAudio.Types (AUDIO, AudioBuffer, AudioBufferSourceNode, Seconds)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)
import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe(..))

-- | A record of options to the function startBufferSource
-- | See Webaudio API AudioBufferSourcenode.start for more information
-- | https://developer.mozilla.org/en-US/docs/Web/API/AudioBufferSourceNode/start
type StartOptions =
  { when ::     Maybe Seconds
  , offset ::   Maybe Seconds
  , duration :: Maybe Seconds
  }

foreign import startBufferSourceFn4
  :: ∀ eff. Seconds
   → Seconds
   → Seconds
   → AudioBufferSourceNode
   → Eff (audio :: AUDIO | eff) Unit

foreign import startBufferSourceFn3
  :: ∀ eff. Seconds
   → Seconds
   → AudioBufferSourceNode
   → Eff (audio :: AUDIO | eff) Unit

foreign import startBufferSourceFn2
  :: ∀ eff. Seconds
   → AudioBufferSourceNode
   → Eff (audio :: AUDIO | eff) Unit

foreign import startBufferSourceFn1
  :: ∀ eff. AudioBufferSourceNode
   → Eff (audio :: AUDIO | eff) Unit


-- | A convenience function specifying the default parameters
-- | for the function startBuffersource
defaultStartOptions :: StartOptions
defaultStartOptions = { when: Nothing, offset: Nothing, duration: Nothing }

-- | Start playing the AudioBuffer. Match on the
-- | record `StartOptions` to determine what options
-- | have been specified by the calling function.
startBufferSource :: ∀ e. StartOptions → AudioBufferSourceNode → Eff (audio :: AUDIO | e) Unit
startBufferSource { when: Just when, offset: Just offset, duration: Just duration } start =
  startBufferSourceFn4 when offset duration start
startBufferSource { when: Just when, offset: Just offset, duration: Nothing } start =
  startBufferSourceFn3 when offset start
startBufferSource { when: Just when, offset: Nothing, duration: Nothing } start =
  startBufferSourceFn2 when start
startBufferSource { when: Nothing, offset: Nothing, duration: Nothing } start =
  startBufferSourceFn1 start
startBufferSource { when: _, offset: _, duration: _ } start =
  startBufferSourceFn1 start

-- | Prime the node with its AudioBuffer.
foreign import setBuffer
  :: ∀ eff. AudioBuffer
  -> AudioBufferSourceNode
  -> (Eff (audio :: AUDIO | eff) Unit)

-- | Stop playing the AudioBuffer.
foreign import stopBufferSource
  :: ∀ eff. Seconds
  -> AudioBufferSourceNode
  -> (Eff (audio :: AUDIO | eff) Unit)

-- | Indicate that the AudioBuffer should be replayed from the start once its
-- | end has been reached.
loop :: ∀ eff. AudioBufferSourceNode -> Eff (audio :: AUDIO | eff) Boolean
loop = unsafeGetProp "loop"

setLoop :: ∀ eff. Boolean -> AudioBufferSourceNode -> Eff (audio :: AUDIO | eff) Unit
setLoop l n = unsafeSetProp "loop" n l

-- | The time, in seconds, at which playback of the AudioBuffer must begin when
-- | loop is true (default 0).
loopStart :: ∀ eff. AudioBufferSourceNode -> Eff (audio :: AUDIO | eff) Seconds
loopStart = unsafeGetProp "loopStart"

setLoopStart :: ∀ eff. Seconds -> AudioBufferSourceNode -> Eff (audio :: AUDIO | eff) Unit
setLoopStart l n = unsafeSetProp "loopStart" n l

-- | The time, in seconds, at which playback of the AudioBuffer must end when
-- | loop is true (default 0).
loopEnd :: ∀ eff. AudioBufferSourceNode -> Eff (audio :: AUDIO | eff) Seconds
loopEnd = unsafeGetProp "loopEnd"

setLoopEnd :: ∀ eff. Seconds -> AudioBufferSourceNode -> Eff (audio :: AUDIO | eff) Unit
setLoopEnd l n = unsafeSetProp "loopEnd" n l
