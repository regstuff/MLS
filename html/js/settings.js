function renderStreamSelectors() {
	const streamSelectors = document.getElementsByClassName('stream-selector');

	for (let selector of streamSelectors) clearAndAddChooseOption(selector);

	for (let i = 1; i <= STREAM_NUM; i++) {
		for (let selector of streamSelectors) {
			let option = document.createElement('option');
			option.value = String(i);
			const name = streamNames[i];
			option.text = 'Stream ' + i + (name ? ': ' + name : '');
			selector.appendChild(option);
		}
	}
}

function renderOutputs() {
	const outSelector = document.getElementById('out-selector');
	clearAndAddChooseOption(outSelector);

	for (let i = 1; i <= OUT_NUM; i++) {
		let option = document.createElement('option');
		option.value = String(i);
		option.text = 'Out ' + i;
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
	let tHeadHtml = '<tr>';
	for (let i = 1; i <= STREAM_NUM; i++) {
		tHeadHtml += `<th>Stream ${i}</th>`;
	}
	tHeadHtml += '</tr>';
	tableHead.innerHTML = tHeadHtml;

	const table = document.getElementById('name-table-body');
	let tr = table.insertRow();
	for (let i = 1; i <= STREAM_NUM; i++) {
		const td = tr.insertCell();
		const input = document.createElement('input');
		input.className = 'input input-bordered w-20 max-w-sm input-xs';
		input.type = 'text';
		input.size = '20';
		input.value = streamNames[i];
		input.name = streamNames[i];
		td.appendChild(input);
	}
}

function extractStreamNamesFromTable() {
	const table = document.getElementById('name-table');

	const ans = ['ignored'];
	const row = table.rows[1];
	for (let i = 0; i < STREAM_NUM; i++) {
		const cell = row.cells[i];
		ans.push(cell.firstChild.value);
	}
	return ans;
}

function saveStreamNamesTable() {
	streamNames = extractStreamNamesFromTable();
	renderStreamSelectors();
	writeStreamNames();
}

window.onload = async function () {
	streamNames = await fetchStreamNames();
	renderOutputs();
	renderStreamNameTable();
	renderStreamSelectors();
};
