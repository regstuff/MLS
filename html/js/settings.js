function renderStreamSelectors() {
	const streamSelectors = document.getElementsByClassName('stream-selector');

	for (let selector of streamSelectors) clearAndAddChooseOption(selector);

	for (let i = 1; i < 21; i++) {
		for (let selector of streamSelectors) {
			let option = document.createElement('option');
			option.value = String(i);
			const name = streamNames[i][0];
			option.text = 'Stream ' + i + (name ? ': ' + name : '');
			selector.appendChild(option);
		}
	}
	const outSelectors = document.getElementsByClassName('out-selector');
}

function updateOutputs() {
	const streamId = Number(document.getElementById('new-destination-stream').value);
	const outSelector = document.getElementById('out-selector');
	clearAndAddChooseOption(outSelector);

	if (streamId === 0) return;
	for (let i = 1; i < 11; i++) {
		let option = document.createElement('option');
		option.value = String(i);
		const suffix = streamNames[streamId][i];
		option.text = 'Out ' + i + (suffix ? ': ' + suffix : '');
		outSelector.appendChild(option);
	}
}

function updateRtmpUrl() {
	const serverUrl = document.getElementById('server-url').value;
	const streamKey = document.getElementById('stream-key').value;
	const rtmpUrl = document.getElementById('rtmp-url');
	rtmpUrl.value = serverUrl + streamKey;
}

function renderStreamNameTable() {
	const table = document.getElementById('name-table-body');

	for (let i = 1; i <= 20; i++) {
		let tr = table.insertRow();
		const td = tr.insertCell();
		td.innerHTML = 'Stream ' + i;
		for (let j = 0; j <= 10; j++) {
			const td = tr.insertCell();
			const input = document.createElement('input');
			input.type = 'text';
			input.size = '10';
			input.value = streamNames[i][j];
			input.name = streamNames[0][j];
			td.appendChild(input);
		}
	}
}

function saveStreamNamesTable() {
	var table = document.getElementById('name-table');

	// Iterate through each row of the table
	for (let i = 1; i < table.rows.length; i++) {
		var rowValues = [];
		var row = table.rows[i];

		// Iterate through each cell in the row
		for (var j = 1; j < row.cells.length; j++) {
			var cell = row.cells[j];
			rowValues.push(cell.firstChild.value);
		}

		streamNames[i] = rowValues;
	}
	renderStreamSelectors();
	writeStreamNames();
}
function writeStreamNames() {
	var xhr = new XMLHttpRequest();
	xhr.open('POST', 'save-stream-names.php', true);
	xhr.setRequestHeader('Content-Type', 'application/json');

	xhr.onreadystatechange = function () {
		if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
			console.log(xhr.responseText);
		}
	};

	var jsonData = JSON.stringify({ csvData: streamNames });
	xhr.send(jsonData);
}

function fetchStreamNames() {
	var xhr = new XMLHttpRequest();
	xhr.open('GET', 'fetch-stream-names.php', true);

	xhr.onreadystatechange = function () {
		if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
			var response = JSON.parse(xhr.responseText);
			streamNames = response.csvData;
			console.log('CSV fetched successfully.');
			renderStreamNameTable();
			renderStreamSelectors();
		}
	};

	xhr.send();
}

window.onload = function () {
	updateOutputs();
	fetchStreamNames();
};
