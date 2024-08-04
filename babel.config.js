module.exports = function(api) {
  api.cache(true);

  const presets = [
    ["@babel/preset-env", {
      "targets": {
        "node": "current"
      },
      "useBuiltIns": "entry",
      "corejs": 3,
      "modules": false
    }]
  ];

  const plugins = [
    "@babel/plugin-syntax-dynamic-import",
    ["@babel/plugin-proposal-class-properties", { "loose": true }],
    ["@babel/plugin-proposal-private-methods", { "loose": true }],
    ["@babel/plugin-proposal-private-property-in-object", { "loose": true }],
    ["@babel/plugin-transform-runtime", {
      "helpers": true,
      "regenerator": true
    }],
    "babel-plugin-macros",
    "@babel/plugin-transform-destructuring",
    ["@babel/plugin-proposal-object-rest-spread", { "useBuiltIns": true }],
    "@babel/plugin-transform-regenerator"
  ];

  return {
    presets,
    plugins
  };
};

