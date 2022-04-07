let mode = undefined;

if (process.env.WATCH == "true") {
  mode = "jit";
}

module.exports = {
  mode,
  purge: [
    '../lib/blabber/web/templates/**/*.html.eex',
    '../lib/blabber/web/**/*.ex'
  ],
  darkMode: false,
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
