function renderStreamControls() {
	const streamControls = document.getElementById('stream-controls');

	for (let i = 1; i <= 20; i++) {
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

		jsmpegDiv.innerHTML += `
		<canvas width="320" height="180" id="video-canvas${i}"></canvas>`;
		jsmpegDiv.innerHTML += `
		<script type="text/javascript">
			var canvas${i} = document.getElementById('video-canvas${i}');
			var url${i} = 'ws://' + document.location.hostname + ':443/';
			var player${i} = 'initial state';
		</script>`;

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
		for (var j = 1; j <= 10; j++) {
			var on = `<button class="small-btn" onclick="executePhpAndShowResponse('/control.php?streamno=${i}&action=out&actnumber=${j}&state=on')">on</button>`;
			var off = `<button class="small-btn off" onclick="executePhpAndShowResponse('/control.php?streamno=${i}&action=out&actnumber=${j}&state=off')">off</button>`;
			const outName = streamNames[i][j];
			const suffix = outName ? ` (${outName})` : '';
			outsDiv.innerHTML += `
			<div class="out-config"><span class="stream-status" id="status${i}-${j}"></span>Out ${j}${suffix}: ${on} | ${off} <div id="destination${i}-${j}" style="margin-left: 30px;"></div></div>`;
		}
		divContainer.appendChild(outsDiv);

		// Other options
		var otherControlsDiv = document.createElement('div');
		otherControlsDiv.innerHTML += `
		<p>
			Record: <button class="small-btn" href="/control.php?streamno=${i}&action=out&actnumber=98&state=on" target="_blank">on</button> |
			<button class="small-btn off" href="/control.php?streamno=${i}&action=out&actnumber=98&state=off" target="_blank">off</button>
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
			<li><span class="stream-status"></span>Main Live Stream:
				<button onclick="executePhpAndShowResponse('/control.php?streamno=${i}&action=main&actnumber=&state=turnon')" class="small-btn" id="stream${i}-main">start</button></li>
			<li><span class="stream-status"></span>Backup Live stream:
				<button href="/control.php?streamno=${i}&action=back&actnumber=&state=turnon" class="small-btn" target="_blank">start</button></li>
			
			<li>
				<form method="post" target="_blank" action="/control.php?streamno=${i}&action=video&actnumber=&state=turnon" style="margin: 0; padding: 0">
					Uploaded Video:
					<select name="video_no">
						<option value="">Choose</option>
						<option value="holding">Holding</option>
						<option value="video">Video</option>
					</select>

				<input type="text" name="startmin" size="1" value="0" />
				<input type="text" style="display: inline" name="startsec" size="1" value="0" />
				<input type="submit" class="small-btn" style="display: inline" value="start" /> |||
				<a href="/control.php?streamno=${i}&action=playlist&actnumber=&state=" target="_blank">Playlist</a> |||
				<a href="/control.php?streamno=${i}&action=off&actnumber=&state=" class="small-btn off" target="_blank">turn off</a>
				</form></li>
		</ul>
		</div>`;

		divContainer.appendChild(otherControlsDiv);

		// Append the divContainer to streamControls section
		streamControls.appendChild(divContainer);
	}
}

async function renderDestinations() {
	streamOutsConfig = await fetchConfigFile();
	for (let i = 1; i <= 20; i++) {
		for (let j = 1; j <= 10; j++) {
			const elem = document.getElementById(`destination${i}-${j}`);
			const info = streamOutsConfig[i][j];
			if (Object.keys(info).length !== 0) {
				elem.innerHTML = `
			Destination (${info.name}, ${info.source}): ${info.url}
			`;
			}
		}
	}
}

window.onload = async function () {
	streamNames = await fetchStreamNames();
	renderStreamControls();
	await renderDestinations();
};
