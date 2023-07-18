function renderStreamControls() {
	const streamControls = document.getElementById('stream-controls');

	for (let i = 1; i <= 20; i++) {
		// Create the div container
		const divContainer = document.createElement('div');
		divContainer.classList.add('padded');

		// Create the h2 title element
		const titleElement = document.createElement('h2');
		titleElement.textContent = 'Stream ' + i;
		divContainer.appendChild(titleElement);

		// Create the div for jsmpeg
		var jsmpegDiv = document.createElement('div');
		jsmpegDiv.classList.add('jsmpeg');

		// Create the canvas element
		var canvasElement = document.createElement('canvas');
		canvasElement.width = '320';
		canvasElement.height = '180';
		canvasElement.id = 'video-canvas' + i;
		jsmpegDiv.appendChild(canvasElement);

		// Create the script element
		var scriptElement = document.createElement('script');
		scriptElement.type = 'text/javascript';
		scriptElement.textContent =
			'var canvas' +
			i +
			" = document.getElementById('video-canvas" +
			i +
			"');\n" +
			'var url' +
			i +
			" = 'ws://' + document.location.hostname + ':443/';\n" +
			'var player' +
			i +
			" = 'initial state';";
		jsmpegDiv.appendChild(scriptElement);

		// Create the p element
		var pElement = document.createElement('p');
		pElement.id = 'stream' + i;

		// Create the anchor elements within p element
		var anchorElements = '';
		var actions = ['main', 'backup', 'distribute'];
		var icons = ['play_arrow', 'play_arrow', 'play_arrow'];
		actions.forEach(function (action, index) {
			anchorElements +=
				'<a href="javascript:void(0);" ' +
				'onclick="genericFunction(\'player.php?appname=' +
				action +
				'&streamname=\', jsmpegPlay, this)">' +
				'<i class="material-icons">' +
				icons[index] +
				'</i>' +
				action.charAt(0).toUpperCase() +
				'</a>';
		});
		anchorElements +=
			'<a href="javascript:void(0);" onclick="jsmpegStop()"><i class="material-icons">stop</i></a>' +
			'<a href="javascript:void(0);" onclick="jsmpegVolumeup()"><i class="material-icons">volume_up</i></a>' +
			'<a href="javascript:void(0);" onclick="jsmpegVolumedown()"><i class="material-icons">volume_down</i></a>';

		pElement.innerHTML = anchorElements;
		jsmpegDiv.appendChild(pElement);

		// Append jsmpegDiv to the divContainer
		divContainer.appendChild(jsmpegDiv);

		var outsDiv = document.createElement('div');
		for (var j = 1; j <= 10; j++) {
			var on = `<a href="/control.php?streamno=${i}&action=out&actnumber=${j}&state=on" target="_blank">On</a>`;
			var off = `<a href="/control.php?streamno=${i}&action=out&actnumber=${j}&state=off" target="_blank">Off</a>`;
			outsDiv.innerHTML += `<p>Out${j}: ${on} ||| ${off}</p>`;
		}
		divContainer.appendChild(outsDiv);

		// Other options
		var otherControlsDiv = document.createElement('div');
		otherControlsDiv.innerHTML += `
		<p>
        Record: <a href="/control.php?streamno=${i}&action=out&actnumber=98&state=on" target="_blank">On</a> |||
        <a href="/control.php?streamno=${i}&action=out&actnumber=98&state=off" target="_blank">Off</a>
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
		<form method="post" target="_blank" action="/control.php?streamno=${i}&action=video&actnumber=&state=turnon" style="margin: 0; padding: 0">
		<div>
		<b>Choose Input:</b> <br />
		<ul>
			<li>Live stream:
				<a href="/control.php?streamno=${i}&action=main&actnumber=&state=turnon" target="_blank">Main</a> |||
				<a href="/control.php?streamno=${i}&action=back&actnumber=&state=turnon" target="_blank">Backup</a></li>
			
			<li>Uploaded Video:
				<select name="video_no">
				<option value="">Choose</option>
				<option value="holding">Holding</option>
				<option value="video">Video</option>
			</select>

			<input type="text" name="startmin" size="1" value="0" />
			<input type="text" style="display: inline" name="startsec" size="1" value="0" />
			<input type="submit" style="display: inline" value="Start" /> |||
			<a href="/control.php?streamno=${i}&action=playlist&actnumber=&state=" target="_blank">Playlist</a> |||
			<a href="/control.php?streamno=${i}&action=off&actnumber=&state=" target="_blank">Turn off</a></li>
		</ul>
		</div>
		</form>`;

		otherControlsDiv.innerHTML += `
		<div class="divider" style="margin: 30px auto;">
			<img src="./img/light-divider.svg" alt="divider" style="margin: 0 50px" />
			<img src="./img/divider.svg" alt="divider" style="margin: 0 50px" />
			<img src="./img/light-divider.svg" alt="divider" style="margin: 0 50px" />
		</div>`;

		divContainer.appendChild(otherControlsDiv);

		// Append the divContainer to streamControls section
		streamControls.appendChild(divContainer);
	}
}

window.onload = async function () {
	streamNames = await fetchStreamNames();
	renderStreamControls();
	fetchStreamNames();
};
