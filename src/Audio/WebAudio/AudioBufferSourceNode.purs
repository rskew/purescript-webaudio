module Audio.WebAudio.AudioBufferSourceNode
  ( setBuffer, startBufferSource, stopBufferSource
  , loop, setLoop, loopStart, setLoopStart, loopEnd, setLoopEnd  ) where

-- | Audio Buffer Source Node.  This is an audio source consisting of in-memory
-- | audio data, stored in an AudioBuffer.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/AudioBufferSourceNode.

import Prelude

import Audio.WebAudio.Types (AUDIO, AudioBuffer, AudioBufferSourceNode, Seconds)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)
import Control.Monad.Eff (Eff)

-- | Prime the node with its AudioBuffer.
foreign import setBuffer
  :: ∀ eff. AudioBuffer
  -> AudioBufferSourceNode
  -> (Eff (audio :: AUDIO | eff) Unit)

-- | Start playing the AudioBuffer.
foreign import startBufferSource
  :: ∀ eff. Seconds
  -> AudioBufferSourceNode
  -> (Eff (audio :: AUDIO | eff) Unit)

-- | Stop playing the AudioBuffer.
foreign import stopBufferSource
  :: ∀ eff. Seconds
  -> AudioBufferSourceNode
  -> (Eff (audio :: AUDIO | eff) Unit)

-- | Indicate that the AudioBuffer should be replayed from the start once its
-- | end has been reached.
loop :: ∀ eff. AudioBufferSourceNode -> (Eff (audio :: AUDIO | eff) Boolean)
loop = unsafeGetProp "loop"

setLoop :: ∀ eff. Boolean -> AudioBufferSourceNode -> (Eff (audio :: AUDIO | eff) Unit)
setLoop l n = unsafeSetProp "loop" n l

-- | The time, in seconds, at which playback of the AudioBuffer must begin when
-- | loop is true (default 0).
loopStart :: ∀ eff. AudioBufferSourceNode -> (Eff (audio :: AUDIO | eff) Seconds)
loopStart = unsafeGetProp "loopStart"

setLoopStart :: ∀ eff. Seconds -> AudioBufferSourceNode -> (Eff (audio :: AUDIO | eff) Unit)
setLoopStart l n = unsafeSetProp "loopStart" n l

-- | The time, in seconds, at which playback of the AudioBuffer must end when
-- | loop is true (default 0).
loopEnd :: ∀ eff. AudioBufferSourceNode -> (Eff (audio :: AUDIO | eff) Seconds)
loopEnd = unsafeGetProp "loopEnd"

setLoopEnd :: ∀ eff. Seconds -> AudioBufferSourceNode -> (Eff (audio :: AUDIO | eff) Unit)
setLoopEnd l n = unsafeSetProp "loopEnd" n l
