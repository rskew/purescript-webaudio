module Audio.WebAudio.Oscillator
  ( OscillatorType(..), readOscillatorType, frequency, detune, setFrequency
  , setDetune, oscillatorType, setOscillatorType, startOscillator
  , stopOscillator) where

-- | Oscillator Node. A periodic waveform, such as a sine wave.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/OscillatorNode.

import Prelude
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, OscillatorNode, AUDIO)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)
import Audio.WebAudio.AudioParam (setValue)

-- | The wave shape.
data OscillatorType = Sine | Square | Sawtooth | Triangle | Custom

instance oscillatorTypeShow :: Show OscillatorType where
    show Sine     = "sine"
    show Square   = "square"
    show Sawtooth = "sawtooth"
    show Triangle = "triangle"
    show Custom   = "custom"

readOscillatorType :: String -> OscillatorType
readOscillatorType "sine"     = Sine
readOscillatorType "square"   = Square
readOscillatorType "sawtooth" = Sawtooth
readOscillatorType "triangle" = Triangle
readOscillatorType "custom"   = Custom
readOscillatorType _          = Sine

derive instance eqOscillatorType :: Eq OscillatorType
derive instance ordOscillatorType :: Ord OscillatorType

-- | The frequency of oscillation in hertz (Hz).
frequency :: ∀ eff. OscillatorNode -> (Eff (audio :: AUDIO| eff) AudioParam)
frequency = unsafeGetProp "frequency"

setFrequency :: ∀ eff. Number -> OscillatorNode -> (Eff (audio :: AUDIO| eff) Unit)
setFrequency num node =
  setValue num =<< frequency node

-- | The frequency of oscillation in cents (1/100 of a semitone).
-- | This is usually more appropriate for music applications.
detune :: ∀ eff. OscillatorNode -> (Eff (audio :: AUDIO | eff) AudioParam)
detune = unsafeGetProp "detune"

setDetune :: ∀ eff. Number -> OscillatorNode -> (Eff (audio :: AUDIO | eff) Unit)
setDetune num node =
  setValue num =<< detune node

oscillatorType :: ∀ eff. OscillatorNode -> (Eff (audio :: AUDIO | eff) OscillatorType)
oscillatorType n = readOscillatorType <$> unsafeGetProp "type" n

setOscillatorType :: ∀ eff. OscillatorType -> OscillatorNode -> (Eff (audio :: AUDIO | eff) Unit)
setOscillatorType t n = unsafeSetProp "type" n $ show t

-- | Start playing the oscillator.
foreign import startOscillator :: ∀ eff. Number -> OscillatorNode -> (Eff (audio :: AUDIO | eff) Unit)

-- | Stop playing the oscillator.
foreign import stopOscillator :: ∀ eff. Number -> OscillatorNode -> (Eff (audio :: AUDIO | eff) Unit)
