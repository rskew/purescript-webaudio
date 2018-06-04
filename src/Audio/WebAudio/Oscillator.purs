module Audio.WebAudio.Oscillator
  ( OscillatorType(..), readOscillatorType, frequency, detune, setFrequency
  , setDetune, oscillatorType, setOscillatorType, startOscillator
  , stopOscillator) where

-- | Oscillator Node. A periodic waveform, such as a sine wave.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/OscillatorNode.

import Prelude
import Effect (Effect)
import Audio.WebAudio.Types (AudioParam, OscillatorNode)
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
frequency :: OscillatorNode -> Effect AudioParam
frequency = unsafeGetProp "frequency"

setFrequency :: Number -> OscillatorNode -> Effect Unit
setFrequency num node =
  setValue num =<< frequency node

-- | The frequency of oscillation in cents (1/100 of a semitone).
-- | This is usually more appropriate for music applications.
detune :: OscillatorNode -> Effect AudioParam
detune = unsafeGetProp "detune"

setDetune :: Number -> OscillatorNode -> Effect Unit
setDetune num node =
  setValue num =<< detune node

oscillatorType :: OscillatorNode -> Effect OscillatorType
oscillatorType n = readOscillatorType <$> unsafeGetProp "type" n

setOscillatorType :: OscillatorType -> OscillatorNode -> Effect Unit
setOscillatorType t n = unsafeSetProp "type" n $ show t

-- | Start playing the oscillator.
foreign import startOscillator :: Number -> OscillatorNode -> Effect Unit

-- | Stop playing the oscillator.
foreign import stopOscillator :: Number -> OscillatorNode -> Effect Unit
