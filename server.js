const BASE_PATH = './html';
const PORT = 3000;

Bun.serve({
	port: PORT,
	async fetch(req) {
		const filePath = BASE_PATH + new URL(req.url).pathname;
		console.log('GET: ' + req.url);
		const file = Bun.file(filePath);
		return new Response(file);
	},
	error() {
		return new Response(null, { status: 404 });
	},
});

console.log('Server listening on port: ' + PORT);
