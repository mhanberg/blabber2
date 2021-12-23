let mode = undefined;

if (process.env.WATCH == "true") {
  mode = "jit";
}

module.exports = {
  mode,
  purge: [
    '../lib/example/web/templates/**/*.html.eex'
  ],
  darkMode: false,
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
