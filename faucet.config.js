let jsConfig = [
  {
    source: "./app/assets/javascripts/application.js",
    target: "./public/assets/javascripts/application.js",
    compact: "minify",
  },
  {
    source: "./app/assets/javascripts/components.js",
    target: "./public/assets/javascripts/components.js",
    compact: "minify",
  }
];

let sassConfig = [
  {
    source: "./app/assets/stylesheets/application.scss",
    target: "./public/assets/stylesheets/application.css"
  }
];

let staticConfig = [
  {
    source: "./app/assets/fonts",
    target: "./public/assets/fonts/"
  },
  {
    source: "./node_modules/@fortawesome/fontawesome-free/webfonts/",
    target: "./public/assets/fonts/"
  },
  {
    source: "./app/assets/images",
    target: "./public/assets/images/"
  }
];

module.exports = {
  js: jsConfig,
  sass: sassConfig,
  static: staticConfig,
  watchDirs: ["./app/assets", "./app/components"],
  manifest: {
    target: "./public/assets/manifest.json",
    key: "short",
    webRoot: "./public"
  }
};
