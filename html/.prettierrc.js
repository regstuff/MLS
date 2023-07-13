module.exports = {
	printWidth: 100,
	useTabs: true,
	tabWidth: 4,
	singleQuote: true,
	semi: true,
	trailingComma: 'all',
	arrowParens: 'always',
	overrides: [
		{
			files: '*.html',
			options: {
				printWidth: 150,
			},
		},
	],
};
