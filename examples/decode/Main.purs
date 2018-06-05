module DecodeAudio where

import Prelude

import Audio.WebAudio.AudioBufferSourceNode (defaultStartOptions, setBuffer, startBufferSource)
import Audio.WebAudio.BaseAudioContext (createBufferSource, decodeAudioData, destination, newAudioContext)
import Audio.WebAudio.Types (AudioBuffer, AudioBufferSourceNode, connect)
import Effect (Effect)
import Effect.Console (warn)
import Data.ArrayBuffer.Types (ArrayBuffer)
import Partial.Unsafe (unsafePartial)
import SimpleDom (DOMEvent, HttpData(..), HttpMethod(..), ProgressEventType(..), XMLHttpRequest, addProgressEventListener, makeXMLHttpRequest, open, response, send, setResponseType)

toArrayBuffer :: forall a. (HttpData a) -> ArrayBuffer
toArrayBuffer hd =
  unsafePartial
    case hd of
      (ArrayBufferData a) -> a

main :: Effect Unit
main = do
  req <- makeXMLHttpRequest
  open GET "decode-audio.wav" req
  setResponseType "arraybuffer" req
  addProgressEventListener ProgressLoadEvent (play req) req
  send NoData req
  pure unit

play :: XMLHttpRequest -- |^ the request object
     -> DOMEvent -- |^ the load event
     -> Effect Unit
play req ev = do
  ctx <- newAudioContext
  src <- createBufferSource ctx
  dst <- destination ctx
  connect src dst
  audioData <- response req
  decodeAudioData ctx (toArrayBuffer audioData) (play0 src) warn

play0 :: AudioBufferSourceNode
      -> AudioBuffer
      -> Effect Unit
play0 src buf = do
  setBuffer buf src
  startBufferSource defaultStartOptions src
