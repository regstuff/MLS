(function renderServerDetails() {
	const address = window.location.hostname;
	const detailsElem = document.getElementById('server-details');
	detailsElem.innerHTML = detailsElem.innerHTML.replaceAll('${address}', address);
})();

const OUTS_MAX_H = 'max-h-52';

function renderStreamControls() {
	const streamControls = document.getElementById('stream-controls');

	for (let i = 1; i <= STREAM_NUM; i++) {
		// Create the div container
		const divContainer = document.createElement('div');
		divContainer.classList.add('stream-container', 'p-2');

		const streamHeader = document.createElement('h');
		streamHeader.id = `streamHeader${i}`;
		streamHeader.classList.add('text-xl');
		divContainer.appendChild(streamHeader);

		divContainer.appendChild(creteJsmpegPlayer(i));

		// creating controls bellow the video preview
		const outsDiv = document.createElement('div');
		outsDiv.id = `stream-outs-${i}`;
		divContainer.appendChild(outsDiv);

		// Other options
		const otherControlsDiv = document.createElement('div');
		otherControlsDiv.innerHTML += `
		<div class="divider"></div>
		<div class="my-1">
			<button class="btn btn-xs btn-primary" href="/control.php?streamno=${i}&action=out&actnumber=98&state=on" target="_blank">on</button>
			<button class="btn btn-xs btn-error" href="/control.php?streamno=${i}&action=out&actnumber=98&state=off" target="_blank">off</button>
			Record
		</div>`;

		otherControlsDiv.innerHTML += `
      <div class="my-1" >
        <b>Overlays:</b> 
        <a href="/control.php?streamno=${i}&action=super&actnumber=1&state=" target="_blank" class="btn btn-xs btn-primary">Add 1</a>
        <a href="/control.php?streamno=${i}&action=super&actnumber=2&state=" target="_blank" class="btn btn-xs btn-primary">Add 2</a>
        <a href="/control.php?streamno=${i}&action=super&actnumber=3&state=" target="_blank" class="btn btn-xs btn-primary">Add 3</a>
        <a href="/control.php?streamno=${i}&action=super&actnumber=4&state=" target="_blank" class="btn btn-xs btn-primary">Add 4</a>
        <a href="/control.php?streamno=${i}&action=super&actnumber=5&state=" target="_blank" class="btn btn-xs btn-primary">Add 5</a>
        <a href="/control.php?streamno=${i}&action=super&actnumber=6&state=" target="_blank" class="btn btn-xs btn-primary">Add 6</a>
        <a href="/control.php?streamno=${i}&action=super&actnumber=7&state=" target="_blank" class="btn btn-xs btn-primary">Add 7</a>
        <a href="/control.php?streamno=${i}&action=super&actnumber=8&state=" target="_blank" class="btn btn-xs btn-primary">Add 8</a>
        <a href="/control.php?streamno=${i}&action=super&actnumber=off&state=" target="_blank" class="btn btn-xs btn-error">Remove</a>
      </div>`;

		otherControlsDiv.innerHTML += `
      <form method="post" target="_blank" action="/control.php?streamno=${i}&action=volume&actnumber=&state=volume">
        <p>
          <b>Volume: </b>
          <input type="text" name="vol_level" size="5" placeholder="1" class="input input-bordered input-neutral input-xs max-w-xs"/>
          <input type="submit" value="Change" class="btn btn-xs btn-outline"/>
        </p>
      </form>`;

		otherControlsDiv.innerHTML += `
		<div>
			<b>Choose Input:</b>
			<div class="my-1">
				<button onclick="executePhpAndShowResponse('/control.php?streamno=${i}&action=main&actnumber=&state=turnon')" 
					id="stream${i}-main" class="btn btn-xs btn-primary">on</button>
				Main Live Stream
			</div>
			<div class="my-1">
				<button href="/control.php?streamno=${i}&action=back&actnumber=&state=turnon" 
					class="btn btn-xs btn-primary" target="_blank">on</button>
				Backup Live stream
			</div>
			
				<form method="post" id="videoInputForm" class="my-1">
					<input type="submit" class="btn btn-xs btn-primary" style="display: inline" value="on" 
						onclick="event.preventDefault(); submitFormAndShowResponse('videoInputForm','control.php?streamno=${i}&action=video&actnumber=&state=turnon');" />
					<btn onclick="executePhpAndShowResponse('/control.php?streamno=${i}&action=off&actnumber=&state=')" class="btn btn-xs btn-error">off</btn>
					<a href="/control.php?streamno=${i}&action=playlist&actnumber=&state=" target="_blank" class="btn btn-xs btn-outline">Playlist</a>
					Uploaded
					<select name="video_no" class="select select-bordered select-xs max-w-xs">
						<option selected value="video">Video</option>
						<option value="holding">Holding</option>
					</select>
					<input type="text" name="startmin" size="1" value="0" class="input input-bordered input-neutral input-xs max-w-xs"/>m
					<input type="text" style="display: inline" name="startsec" size="1" value="0" class="input input-bordered input-neutral input-xs max-w-xs"/>s
				</form>
		</div>`;

		divContainer.appendChild(otherControlsDiv);
		streamControls.appendChild(divContainer);
	}
}

function renderStreamHeaders() {
	const actives = getActiveStreams();
	let statuses = Array(STREAM_NUM);
	actives.forEach((stream) => (statuses[stream.id] = true));

	for (let i = 1; i <= STREAM_NUM; i++) {
		const headerElem = document.getElementById(`streamHeader${i}`);
		const streamName = streamNames[i];
		const suffix = streamName ? ` (${streamName})` : '';
		headerElem.innerHTML = `
			<span class="stream-status ${statuses[i] ? 'on' : 'off'}" id="status${i}"></span>
			Stream ${i}${suffix}`;
	}
}

function renderOuts() {
	const actives = getActiveOuts();
	let statuses = Array(STREAM_NUM)
		.fill()
		.map((_) => []);
	actives.forEach((out) => (statuses[out.streamId][out.outId] = true));

	for (let i = 1; i <= STREAM_NUM; i++) {
		const outsDiv = document.getElementById(`stream-outs-${i}`);

		let outsHtml = '';
		// we need to slice slice(0, STREAM_NUM) because outs 98 are used for recording.
		const outSize = streamOutsConfig[i]
			.slice(0, STREAM_NUM)
			.findLastIndex((info) => !isEmpty(info));
		for (var j = 1; j <= outSize; j++) {
			const outInfo = streamOutsConfig[i][j];
			const on = `<button class="btn btn-xs btn-primary" 
				onclick="executePhpAndShowResponse('/control.php?streamno=${i}&action=out&actnumber=${j}&state=on')">on</button>`;
			const off = `<button class="btn btn-xs btn-error" 
				onclick="executePhpAndShowResponse('/control.php?streamno=${i}&action=out&actnumber=${j}&state=off')">off</button>`;
			let name = outInfo.encoding === 'vertical' ? `<b>Vertical Out ${j}</b>` : `Out ${j}`;
			const destName = outInfo.name ? `: ${outInfo.name}` : ``;
			outsHtml += `
				<div class="my-1">
					<span class="stream-status ${statuses[i][j] ? 'on' : 'off'}" id="status${i}-${j}"></span>
					${on} ${off} ${name}<span id="destination${i}-${j}">${destName}</span>
				</div>`;
		}
		if (outSize < 1) {
			outsHtml += 'No configured outs...';
		}

		outsDiv.innerHTML = outsHtml;
	}
}

function parseOutputStreamName(str) {
	const dashIndex = str.indexOf('-');
	return {
		streamId: Number(str.substring(6, dashIndex)),
		destinationName: str.substring(dashIndex + 1),
	};
}

function getActiveOuts() {
	let outStreams = statsJson.rtmp.server.application.find((app) => app.name['#text'] == 'output')
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

function getActiveStreams() {
	// TODO
	return [];
}

// ===== jsmpeg player =====
var canvas1 = document.getElementById('video-canvas1');
var url1 = 'ws://' + document.location.hostname + ':443/';
var player1 = 'initial state';

function setVideoPlayers() {
	for (let i = 1; i <= STREAM_NUM; i++) {
		for (let j = 1; j <= OUT_NUM; j++) {
			eval(`window.canvas${i} = document.getElementById('video-canvas${i}');`);
			eval(`window.url${i} = 'ws://' + document.location.hostname + ':443/';`);
			eval(`window.player${i} = 'initial state';`);
		}
	}
}

function creteJsmpegPlayer(streamId) {
	const jsmpegDiv = document.createElement('div');
	jsmpegDiv.classList.add('jsmpeg', 'text-center');

	if (streamId === 1) {
		jsmpegDiv.innerHTML = `
				<canvas width="320" height="180" id="video-canvas${streamId}"
					class="inline border border-solid border-gray-400"></canvas>`;
	}

	// Create jsmpeg player controls
	const controlsElem = document.createElement('p');
	controlsElem.id = 'stream' + streamId;

	controlsElem.innerHTML = `
		<a href="javascript:void(0);" onclick="genericFunction('player.php?appname=main&streamname=', jsmpegPlay, this)" class="mx-1">
			<i class="material-icons text-3xl">play_arrow</i>M</a>
		<a href="javascript:void(0);" onclick="genericFunction('player.php?appname=backup&streamname=', jsmpegPlay, this)" class="mx-1">
			<i class="material-icons text-3xl">play_arrow</i>B</a>
		<a href="javascript:void(0);" onclick="genericFunction('player.php?appname=distribute&streamname=', jsmpegPlay, this)" class="mx-1">
			<i class="material-icons text-3xl">play_arrow</i>D</a>
		<a href="javascript:void(0);" onclick="jsmpegStop()" class="mx-1"><i class="material-icons text-3xl">stop</i></a>
		<a href="javascript:void(0);" onclick="jsmpegVolumeup()" class="mx-1"><i class="material-icons text-3xl">volume_up</i></a>
		<a href="javascript:void(0);" onclick="jsmpegVolumedown()" class="mx-1"><i class="material-icons text-3xl">volume_down</i></a>`;

	jsmpegDiv.appendChild(controlsElem);
	return jsmpegDiv;
}

function genericFunction(url, cFunction, elem) {
	var streamno = elem.parentNode.id;
	url += streamno;
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function () {
		if (this.readyState == 4 && this.status == 200) {
			cFunction(this, streamno);
		}
	};
	xhttp.open('GET', url, true);
	xhttp.send();
}

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
// ===== jsmpeg player =====

window.onload = async function () {
	renderStreamControls();
	setVideoPlayers();
	setInterval(async function () {
		streamNames = await fetchStreamNames();
		statsJson = await fetchStats();
		streamOutsConfig = await fetchConfigFile();
		renderStreamHeaders();
		renderOuts();
	}, 3000);
};
