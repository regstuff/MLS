/** @type {import('tailwindcss').Config} */
module.exports = {
	content: ['./html/**/*.{html,js}'],
	theme: {
		extend: {},
	},
	plugins: [require('@tailwindcss/typography'), require('daisyui')],
	daisyui: {
		themes: ['dim', 'night'],
	},
};
