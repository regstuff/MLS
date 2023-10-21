function renderStreamSelectors() {
	const streamSelectors = document.getElementsByClassName('stream-selector');

	for (let selector of streamSelectors) clearAndAddChooseOption(selector);

	for (let i = 1; i <= STREAM_NUM; i++) {
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
	for (let i = 1; i <= OUT_NUM; i++) {
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
	const tableHead = document.getElementById('name-table').tHead;
	let tHeadHtml = '<tr><th></th><th>Name</th>';
	for (let j = 1; j <= OUT_NUM; j++) {
		tHeadHtml += `<th>Out${j}</th>`;
	}
	tHeadHtml += '</tr>';
	tableHead.innerHTML = tHeadHtml;

	const table = document.getElementById('name-table-body');
	for (let i = 1; i <= STREAM_NUM; i++) {
		let tr = table.insertRow();
		const td = tr.insertCell();
		td.innerHTML = 'Stream' + i;
		for (let j = 0; j <= OUT_NUM; j++) {
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
window.onload = async function () {
	streamNames = await fetchStreamNames();
	updateOutputs();
	renderStreamNameTable();
	renderStreamSelectors();
};
