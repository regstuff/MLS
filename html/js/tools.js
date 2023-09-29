// CONSTANTS
const STREAM_NUM = 25;
const OUT_NUM = 95;

// Tools
function removeAllChildNodes(parent) {
	while (parent.firstChild) {
		parent.removeChild(parent.firstChild);
	}
}
function clearAndAddChooseOption(selector) {
	removeAllChildNodes(selector);
	let option = document.createElement('option');
	option.value = '';
	option.text = 'Choose';
	selector.appendChild(option);
}
// This will be fetched from a file
let streamNames = [];
let streamOutsConfig = [];

// AJAX request function
async function submitFormAndShowResponse(formId, phpUrl) {
	var form = document.getElementById(formId);
	if (form.checkValidity()) {
		try {
			var formData = new FormData(form);
			var response = await fetch(phpUrl, { method: 'POST', body: formData });
			if (response.ok) {
				showResponse(await response.text());
			} else {
				console.error('Request failed with status:', response.status);
			}
		} catch (error) {
			console.error('Error:', error);
		}
	} else {
		form.reportValidity();
	}
}

// AJAX request function
async function executePhpAndShowResponse(phpUrl) {
	var response = await fetch(phpUrl, { method: 'POST' });
	if (response.ok) {
		showResponse(await response.text());
		refreshStatuses();
	} else {
		console.error('Request failed with status:', response.status);
	}
}

function showResponse(response) {
	var responseBox = document.getElementById('responseBox');
	responseBox.innerHTML += `<p>${response}</p><div class="divider"><img src="./img/divider.svg" alt="divider" /></div>`;
}

async function fetchStats() {
	try {
		const response = await fetch('/stat-test.xml');
		const data = await response.text();
		const parser = new DOMParser();
		const xmlData = parser.parseFromString(data, 'text/xml');
		return xml2json(xmlData);
	} catch (error) {
		console.error('Error fetching stats data:', error);
	}
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

async function fetchStreamNames() {
	try {
		const response = await fetch('fetch-stream-names.php');
		if (!response.ok) {
			throw new Error(`HTTP error! Status: ${response.status}`);
		}
		const data = await response.json();
		const streamNames = data.csvData;
		console.log('CSV fetched successfully.');
		return streamNames;
	} catch (error) {
		console.error('Error fetching stream names:', error);
		throw error; // Propagate the error to the caller
	}
}

async function fetchConfigFile() {
	const response = await fetch('/config.txt');
	const text = await response.text();
	const lines = text.split('\n');

	const streamOutsConfig = [];
	for (let i = 1; i <= STREAM_NUM; i++) {
		streamOutsConfig[i] = [];
		for (let j = 1; j <= OUT_NUM; j++) {
			streamOutsConfig[i][j] = {};
		}
	}

	for (const line of lines) {
		const matches = line.match(/^__stream(\d+)__out(\d+)__(.*)$/);
		if (matches) {
			const i = parseInt(matches[1]);
			const j = parseInt(matches[2]);
			let remainingLine = matches[3].trim();
			const split = remainingLine.split(' ');

			if (split.length === 3) {
				streamOutsConfig[i][j] = { url: split[0], source: split[1], name: split[2] };
			} else {
				streamOutsConfig[i][j] = {};
			}
		}
	}

	return streamOutsConfig;
}

function xml2json(xml) {
	// Create the return object
	var obj = {};

	if (xml.nodeType == 1) {
		// element
		// do attributes
		if (xml.attributes.length > 0) {
			obj['@attributes'] = {};
			for (var j = 0; j < xml.attributes.length; j++) {
				var attribute = xml.attributes.item(j);
				obj['@attributes'][attribute.nodeName] = attribute.nodeValue;
			}
		}
	} else if (xml.nodeType == 3) {
		// text
		obj = xml.nodeValue;
	}

	// do children
	if (xml.hasChildNodes()) {
		for (var i = 0; i < xml.childNodes.length; i++) {
			var item = xml.childNodes.item(i);
			var nodeName = item.nodeName;
			if (typeof obj[nodeName] == 'undefined') {
				obj[nodeName] = xml2json(item);
			} else {
				if (typeof obj[nodeName].push == 'undefined') {
					var old = obj[nodeName];
					obj[nodeName] = [];
					obj[nodeName].push(old);
				}
				obj[nodeName].push(xml2json(item));
			}
		}
	}
	return obj;
}
