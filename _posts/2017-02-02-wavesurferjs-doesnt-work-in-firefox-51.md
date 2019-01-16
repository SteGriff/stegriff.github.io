# Wavesurfer.js doesn't work in Firefox 51

wavesurfer.js doesn't play audio for me in Firefox, unless you set the `backend` option to `MediaElement`. 

## Fault description

When not working, it will draw the waveform and allow you to click around to move the seek point, but it won't play any sound. The `ready` event is fired during setup. After this, I can trigger play, and the `play` event will fire. The `wavesurfer.isPlaying` property will change to true, but the seek bar does not move, and the sound does not play. My Firefox is v51.0.1 (32 bit) on Windows.

## Resolution

I have tried to make sure the `ready` event was fired before playing, and other tricks, but they didn't work. Eventually my solution was to use the `MediaElement` backend. The added upside is that I no longer need to care about the `ready` event because the MediaElement can play even before the waveform is drawn.

Here's my most minimal test case which *does* work in Firefox (it uses some local audio which you will need to replace):

	<!DOCTYPE HTML>
	<html>
	<head>
	<title></title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/wavesurfer.js/1.3.0/wavesurfer.min.js"></script>
	</head>
	<body>
		<div class="js-waveform"></div>
		<button onclick="play()">Play</button>
		<script>
		var wavesurfer = null;

		var play = function()
		{
			wavesurfer.play();
		}

		var prepare = function ()
		{
			wavesurfer = WaveSurfer.create({
				container: ".js-waveform",
				backend: 'MediaElement'
			});

			wavesurfer.on('ready', function () {
				wavesurfer.play();
			});

			wavesurfer.load('audio/TranscriptionTest2.wav');
		}();

		</script>
	</body>
	</html>