exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js"

      // To use a separate vendor.js bundle, specify two files path
      // http://brunch.io/docs/config#-files-
      // joinTo: {
      //   "js/app.js": /^js/,
      //   "js/vendor.js": /^(?!js)/
      // }
      //
      // To change the order of concatenation of files, explicitly mention here
      // order: {
      //   before: [
      //     "vendor/js/jquery-2.1.1.js",
      //     "vendor/js/bootstrap.min.js"
      //   ]
      // }
    },
    stylesheets: {
      joinTo: "css/app.css"
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "elm", "js", "vendor"],
    // Where to compile files to
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
    },

    elmBrunch: {
      elmFolder: "elm",
      mainModules: ["Main.elm", "App.elm"],
      outputFolder: "../vendor",
      outputFile: "elm.js",
      makeParameters: ["--warn"]
    },
    sass: {
      mode: 'native',
      options: {
        includePaths: ["node_modules/font-awesome/scss", "node_modules/bootstrap/scss"], // Tell sass-brunch where to look for files to @import
        precision: 8 // Minimum precision required by bootstrap-sass
       }
     },
   copycat: {
     "fonts" : ["static/fonts", "node_modules/font-awesome/fonts"],
     verbose : false, //shows each file that is copied to the destination directory
     onlyChanged: true //only copy a file if it's modified time has changed (only effective when using brunch watch)
   }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true,
    globals: { // Bootstrap's JavaScript requires both '$' and 'jQuery' in global scope
    $: 'jquery',
    jQuery: 'jquery',
    Tether: 'tether',
    Popper: 'popper.js',
    bootstrap: 'bootstrap', // Require Bootstrap's JavaScript globally
    }
  }
};
