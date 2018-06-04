module Audio.WebAudio.BiquadFilterNode
  ( BiquadFilterType(..), readBiquadFilterType, filterType, setFilterType
  , filterFrequency, quality, gain) where

-- | Biquad Filter Node. This is a node which can represent different kinds of
-- | filters, tone control devices, or graphic equalizers.
-- | See https://developer.mozilla.org/en-US/docs/Web/API/BiquadFilterNode.

import Audio.WebAudio.Types
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)
import Prelude (class Show, class Eq, class Ord, Unit, show, (<$>))

import Effect (Effect)

-- | The filter type selects the filtering algorithm which in turn selects the
-- | range of frequencies to be filtered.
data BiquadFilterType =
    Lowpass
  | Highpass
  | Bandpass
  | Lowshelf
  | Highshelf
  | Peaking
  | Notch
  | Allpass

instance biquadFilterTypeShow :: Show BiquadFilterType where
    show Lowpass   = "lowpass"
    show Highpass  = "highpass"
    show Bandpass  = "bandpass"
    show Lowshelf  = "lowshelf"
    show Highshelf = "highshelf"
    show Peaking   = "peaking"
    show Notch     = "notch"
    show Allpass   = "allpass"

derive instance eqBiquadFilterType :: Eq BiquadFilterType
derive instance ordBiquadFilterType :: Ord BiquadFilterType


readBiquadFilterType :: String -> BiquadFilterType
readBiquadFilterType "lowpass"   = Lowpass
readBiquadFilterType "highpass"  = Highpass
readBiquadFilterType "bandpass"  = Bandpass
readBiquadFilterType "highshelf" = Highshelf
readBiquadFilterType "peaking"   = Peaking
readBiquadFilterType "notch"     = Notch
readBiquadFilterType "allpass"   = Allpass
readBiquadFilterType _           = Lowpass

filterType :: ∀ eff. BiquadFilterNode -> Effect BiquadFilterType
filterType n = readBiquadFilterType <$> unsafeGetProp "type" n

setFilterType :: ∀ eff. BiquadFilterType -> BiquadFilterNode -> Effect Unit
setFilterType t n = unsafeSetProp "type" n (show t)

-- | The frequency in the current filtering algorithm measured in hertz (Hz).
filterFrequency :: ∀ eff. BiquadFilterNode -> Effect AudioParam
filterFrequency = unsafeGetProp "frequency"

-- | The quality (or Q-Factor) represents the degree of resonance exhibited
-- | by the filter. See https://en.wikipedia.org/wiki/Q_factor.
quality :: ∀ eff. BiquadFilterNode -> Effect AudioParam
quality = unsafeGetProp "Q"

-- | The gain used in the current filtering algorithm.
foreign import gain
  :: forall eff. BiquadFilterNode -> Effect AudioParam
