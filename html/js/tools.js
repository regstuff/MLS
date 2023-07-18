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
let streamNames = [
	[
		'Name',
		'Out 1',
		'Out 2',
		'Out 3',
		'Out 4',
		'Out 5',
		'Out 6',
		'Out 7',
		'Out 8',
		'Out 9',
		'Out 10',
	],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
	['', '', '', '', '', '', '', '', '', '', ''],
];

// AJAX request function
function sendRequest(formId, phpUrl) {
	var form = document.getElementById(formId);
	if (form.checkValidity()) {
		var xhr = new XMLHttpRequest();
		xhr.open('POST', phpUrl, true);
		xhr.onreadystatechange = function () {
			if (xhr.readyState === XMLHttpRequest.DONE) {
				var responseBox = document.getElementById('responseBox');
				responseBox.innerHTML +=
					'<p>' +
					xhr.responseText +
					'</p><div class="divider"><img src="./img/divider.svg" alt="divider" /></div>';
			}
		};
		var formData = new FormData(form);
		xhr.send(formData);
	} else {
		form.reportValidity();
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
