module Audio.WebAudio.AnalyserNode
  (fftSize, frequencyBinCount, setFftSize, setFrequencyBinCount,
    minDecibels, setMinDecibels, maxDecibels, setMaxDecibels,
    smoothingTimeConstant, setSmoothingTimeConstant,
    getFloatFrequencyData, getByteFrequencyData, getFloatTimeDomainData,
    getByteTimeDomainData ) where

-- | Analyser Node.  See https://developer.mozilla.org/en-US/docs/Web/API/AnalyserNode.

import Prelude (Unit)
import Effect (Effect)
import Data.ArrayBuffer.Types (ByteLength, Uint8Array, Float32Array)
import Audio.WebAudio.Types (AnalyserNode)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)

-- | The size of the FFT (Fast Fourier Transform) to be used to determine the
-- | frequency domain.
-- | Its value must be a non-zero power of 2 in a range from 32 to 32768;
-- | its default value is 2048.
-- | If its value is not a power of 2, or it is outside the specified range,
-- | the exception INDEX_SIZE_ERR is thrown.
fftSize :: AnalyserNode → Effect ByteLength
fftSize n = unsafeGetProp "fftSize" n

setFftSize :: ByteLength → AnalyserNode → Effect Unit
setFftSize size n = unsafeSetProp "fftSize" n size

-- | Half that of the FFT size. This generally equates to the number of data
-- | values you will have to play with for the visualization.
frequencyBinCount :: AnalyserNode → Effect ByteLength
frequencyBinCount n = unsafeGetProp "frequencyBinCount" n

setFrequencyBinCount :: ByteLength → AnalyserNode → Effect Unit
setFrequencyBinCount count n = unsafeSetProp "frequencyBinCount" n count

-- | Specifies the minimum value for the range of results when using
-- | getByteFrequencyData().
minDecibels :: AnalyserNode → Effect Number
minDecibels n = unsafeGetProp "minDecibels" n

setMinDecibels :: Number → AnalyserNode → Effect Unit
setMinDecibels db n = unsafeSetProp "minDecibels" n db

-- | Specifies the maxi0mum value for the range of results when using
-- | getByteFrequencyData().
maxDecibels :: AnalyserNode → Effect Number
maxDecibels n = unsafeGetProp "maxDecibels" n

setMaxDecibels :: Number → AnalyserNode → Effect Unit
setMaxDecibels db n = unsafeSetProp "maxDecibels" n db

-- | The averaging constant with the last analysis frame.
-- | This makes the transition between values over time smoother.
smoothingTimeConstant :: AnalyserNode → Effect Number
smoothingTimeConstant n = unsafeGetProp "smoothingTimeConstant" n

setSmoothingTimeConstant :: Number → AnalyserNode → Effect Unit
setSmoothingTimeConstant tc n = unsafeSetProp "smoothingTimeConstant" n tc


-- | Copy the current frequency data into the Float32Array.
foreign import getFloatFrequencyData :: AnalyserNode → Float32Array → Effect Unit

-- | Copy the current frequency data into the Uint8Array.
foreign import getByteFrequencyData :: AnalyserNode → Uint8Array → Effect Unit

-- | Copy the current waveform, or time-domain, data into the Float32Array.
foreign import getFloatTimeDomainData :: AnalyserNode → Float32Array → Effect Unit

-- | Copy the current waveform, or time-domain, data into the Uint8Array.
foreign import getByteTimeDomainData :: AnalyserNode → Uint8Array → Effect Unit
