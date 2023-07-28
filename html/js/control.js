function renderStreamControls() {
	const streamControls = document.getElementById('stream-controls');

	for (let i = 1; i <= STREAM_NUM; i++) {
		// Create the div container
		const divContainer = document.createElement('div');
		divContainer.classList.add('padded');

		divContainer.innerHTML += `
		<div class="divider" style="margin: 30px auto;">
			<img src="./img/red-divider.svg" alt="divider" />
		</div>`;
		const streamName = streamNames[i][0];
		const suffix = streamName ? ` (${streamName})` : '';
		divContainer.innerHTML += `<h2>Stream ${i}${suffix}</h2>`;

		// Create the div for jsmpeg
		var jsmpegDiv = document.createElement('div');
		jsmpegDiv.classList.add('jsmpeg');

		if (i === 1) {
			jsmpegDiv.innerHTML += `
			<canvas width="320" height="180" id="video-canvas${i}"></canvas>`;
		}

		// Create the p element
		var pElement = document.createElement('p');
		pElement.id = 'stream' + i;

		// Create the anchor elements within p element
		var anchorElements = '';
		var actions = ['main', 'backup', 'distribute'];
		var icons = ['play_arrow', 'play_arrow', 'play_arrow'];
		actions.forEach(function (action, index) {
			anchorElements += `
				<a href="javascript:void(0);" onclick="genericFunction('player.php?appname=${action}&streamname=', jsmpegPlay, this)">
					<i class="material-icons">${icons[index]}</i>${action.charAt(0).toUpperCase()}
				</a>`;
		});
		anchorElements += `
		<a href="javascript:void(0);" onclick="jsmpegStop()"><i class="material-icons">stop</i></a>
		<a href="javascript:void(0);" onclick="jsmpegVolumeup()"><i class="material-icons">volume_up</i></a>
		<a href="javascript:void(0);" onclick="jsmpegVolumedown()"><i class="material-icons">volume_down</i></a>`;

		pElement.innerHTML = anchorElements;
		jsmpegDiv.appendChild(pElement);

		// Append jsmpegDiv to the divContainer
		divContainer.appendChild(jsmpegDiv);

		// creating controls bellow the video preview
		var outsDiv = document.createElement('div');
		outsDiv.classList.add('stream-outs');
		outsDiv.id = `stream-outs-${i}`;
		for (var j = 1; j <= OUT_NUM; j++) {
			if (i !== 1 && j > 20) break;
			var on = `<button class="small-btn" onclick="executePhpAndShowResponse('/control.php?streamno=${i}&action=out&actnumber=${j}&state=on')">on</button>`;
			var off = `<button class="small-btn off" onclick="executePhpAndShowResponse('/control.php?streamno=${i}&action=out&actnumber=${j}&state=off')">off</button>`;
			const outName = streamNames[i][j];
			const suffix = outName ? ` (${outName})` : '';
			outsDiv.innerHTML += `
			<div class="out-config"><span class="stream-status" id="status${i}-${j}"></span>${on} | ${off} Out ${j}${suffix}<span id=outStreams"destination${i}-${j}"></span></div>`;
		}
		divContainer.appendChild(outsDiv);
		divContainer.innerHTML += `<button id="show-outs-${i}" class="show-or-hide-btn small-btn" onclick="toggleOuts(${i})">Show More</button>`;

		// Other options
		var otherControlsDiv = document.createElement('div');
		otherControlsDiv.innerHTML += `
		<p>
			<button class="small-btn" href="/control.php?streamno=${i}&action=out&actnumber=98&state=on" target="_blank">on</button> |
			<button class="small-btn off" href="/control.php?streamno=${i}&action=out&actnumber=98&state=off" target="_blank">off</button>
			Record
		</p>`;

		otherControlsDiv.innerHTML += `
      <p>
        Instagram: <a href="/control.php?streamno=${i}&action=insta&actnumber=&state=on" target="_blank">On</a> |||
        <a href="/control.php?streamno=${i}&action=instaoff&actnumber=&state=" target="_blank">Off</a> ||| For Emergencies --> |||
        <a href="/control.php?streamno=${i}&action=out&actnumber=99&state=on" target="_blank">Turn on out99</a> |||
        <a href="/control.php?streamno=${i}&action=out&actnumber=99&state=off" target="_blank">Turn off out99</a>
      </p>`;

		otherControlsDiv.innerHTML += `
      <p>
        <b>Overlays:</b> 
        <a href="/control.php?streamno=${i}&action=super&actnumber=1&state=" target="_blank">Add 1</a> |||
        <a href="/control.php?streamno=${i}&action=super&actnumber=2&state=" target="_blank">Add 2</a> |||
        <a href="/control.php?streamno=${i}&action=super&actnumber=3&state=" target="_blank">Add 3</a> |||
        <a href="/control.php?streamno=${i}&action=super&actnumber=4&state=" target="_blank">Add 4</a> |||
        <a href="/control.php?streamno=${i}&action=super&actnumber=5&state=" target="_blank">Add 5</a> |||
        <a href="/control.php?streamno=${i}&action=super&actnumber=6&state=" target="_blank">Add 6</a> |||
        <a href="/control.php?streamno=${i}&action=super&actnumber=7&state=" target="_blank">Add 7</a> |||
        <a href="/control.php?streamno=${i}&action=super&actnumber=8&state=" target="_blank">Add 8</a> |||
        <a href="/control.php?streamno=${i}&action=super&actnumber=off&state=" target="_blank">Remove</a>
      </p>`;

		otherControlsDiv.innerHTML += `
      <form method="post" target="_blank" action="/control.php?streamno=${i}&action=volume&actnumber=&state=volume">
        <p>
          <b>Volume: </b>
          <input type="text" name="vol_level" size="5" placeholder="1" />
          <input type="submit" value="Change" />
        </p>
      </form>`;

		otherControlsDiv.innerHTML += `
		<div>
		<b>Choose Input:</b>
		<ul class="input-options">
			<li>
				<button onclick="executePhpAndShowResponse('/control.php?streamno=${i}&action=main&actnumber=&state=turnon')" class="small-btn" id="stream${i}-main">start</button>
				Main Live Stream
			</li>
			<li>
				<button href="/control.php?streamno=${i}&action=back&actnumber=&state=turnon" class="small-btn" target="_blank">start</button>
				Backup Live stream
			</li>
			
			<li>
				<form method="post" target="_blank" action="/control.php?streamno=${i}&action=video&actnumber=&state=turnon" style="margin: 0; padding: 0">
				<input type="submit" class="small-btn" style="display: inline" value="start" /> |
				<a href="/control.php?streamno=${i}&action=off&actnumber=&state=" class="small-btn off" target="_blank">turn off</a> |||
				<a href="/control.php?streamno=${i}&action=playlist&actnumber=&state=" target="_blank">Playlist</a> |||
					Uploaded Video:
					<select name="video_no">
						<option value="">Choose</option>
						<option value="holding">Holding</option>
						<option value="video">Video</option>
					</select>

				<input type="text" name="startmin" size="1" value="0" />
				<input type="text" style="display: inline" name="startsec" size="1" value="0" />
				</form></li>
		</ul>
		</div>`;

		divContainer.appendChild(otherControlsDiv);

		// Append the divContainer to streamControls section
		streamControls.appendChild(divContainer);
	}
}

function toggleOuts(streamId) {
	const outs = document.getElementById(`stream-outs-${streamId}`);
	const showMoreBtn = document.getElementById(`show-outs-${streamId}`);

	if (outs.classList.contains('show-more')) {
		// Hide the full text
		outs.classList.remove('show-more');
		showMoreBtn.textContent = 'show more';
	} else {
		// Show the full text
		outs.classList.add('show-more');
		showMoreBtn.textContent = 'hide';
	}
}

async function renderDestinations() {
	streamOutsConfig = await fetchConfigFile();
	for (let i = 1; i <= STREAM_NUM; i++) {
		for (let j = 1; j <= OUT_NUM; j++) {
			const elem = document.getElementById(`destination${i}-${j}`);
			const info = streamOutsConfig[i][j];
			if (Object.keys(info).length !== 0) {
				elem.innerHTML = `, destination: ${info.name}`;
			}
		}
	}
}

function parseOutputStreamName(str) {
	const dashIndex = str.indexOf('-');
	return {
		streamId: str.substring(6, dashIndex),
		destinationName: str.substring(dashIndex + 1),
	};
}

async function fetchActiveOuts() {
	streamOutsConfig = await fetchConfigFile();
	const rtmpJson = await fetchStats();

	let outStreams = rtmpJson.rtmp.server.application.find((app) => app.name['#text'] == 'output')
		.live.stream;
	if (outStreams === undefined) return [];
	if (!Array.isArray(outStreams)) outStreams = [outStreams];
	outStreams = outStreams.map((s) => s.name['#text']);
	return outStreams
		.map((name) => parseOutputStreamName(name))
		.map((p) => ({
			streamId: p.streamId,
			outId: streamOutsConfig[p.streamId].findIndex(
				(info) => info?.name === p.destinationName,
			),
		}))
		.filter((p) => p.outId !== -1);
}

async function refreshStatuses() {
	const activeOuts = await fetchActiveOuts();
	const activeStatusIds = activeOuts.map((p) => `status${p.streamId}-${p.outId}`);
	Array.from(document.getElementsByClassName('stream-status')).forEach((s) => {
		s.className = activeStatusIds.includes(s.id)
			? (s.className = 'stream-status on')
			: (s.className = 'stream-status off');
	});
}

function setVideoPlayers() {
	for (let i = 1; i <= STREAM_NUM; i++) {
		for (let j = 1; j <= OUT_NUM; j++) {
			eval(`window.canvas${i} = document.getElementById('video-canvas${i}');`);
			eval(`window.url${i} = 'ws://' + document.location.hostname + ':443/';`);
			eval(`window.player${i} = 'initial state';`);
		}
	}
}

function genericFunction(url, cFunction, elem) {
	var streamno = elem.parentNode.id;
	url += streamno;
	console.log(url);
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function () {
		if (this.readyState == 4 && this.status == 200) {
			cFunction(this, streamno);
		}
	};
	xhttp.open('GET', url, true);
	xhttp.send();
}

function loadText(xhttp, streamno) {
	document.getElementById('demo').innerHTML = xhttp.responseText;
}

var canvas1 = document.getElementById('video-canvas1');
var url1 = 'ws://' + document.location.hostname + ':443/';
var player1 = 'initial state';

function jsmpegPlay(xhttp, streamno) {
	var stream1 = document.getElementById(streamno);
	stream1.parentElement.insertBefore(canvas1, stream1);
	if (player1 == 'initial state') {
		player1 = new JSMpeg.Player(url1, {
			canvas: canvas1,
			autoplay: false,
			pauseWhenHidden: false,
			videoBufferSize: 100 * 1024,
			audioBufferSize: 50 * 1024,
		});
	}
	player1.play();
	player1.volume = 1;
	return false;
}

function jsmpegStop() {
	player1.stop();
	return false;
}

function jsmpegVolumeup() {
	player1.volume = player1.volume + 0.2;
	return false;
}

function jsmpegVolumedown() {
	player1.volume = player1.volume - 0.2;
	if (player1.volume < 0) {
		player1.volume = 0;
	}
	return false;
}

window.onload = async function () {
	streamNames = await fetchStreamNames();
	renderStreamControls();
	await renderDestinations();
	setVideoPlayers();
	setInterval(refreshStatuses, 3000);
};
