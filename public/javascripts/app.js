(function(/*! Brunch !*/) {
  'use strict';

  var globals = typeof window !== 'undefined' ? window : global;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};

  var has = function(object, name) {
    return hasOwnProperty.call(object, name);
  };

  var expand = function(root, name) {
    var results = [], parts, part;
    if (/^\.\.?(\/|$)/.test(name)) {
      parts = [root, name].join('/').split('/');
    } else {
      parts = name.split('/');
    }
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function(name) {
      var dir = dirname(path);
      var absolute = expand(dir, name);
      return require(absolute);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    definition(module.exports, localRequire(name), module);
    var exports = cache[name] = module.exports;
    return exports;
  };

  var require = function(name) {
    var path = expand(name, '.');

    if (has(cache, path)) return cache[path];
    if (has(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has(cache, dirIndex)) return cache[dirIndex];
    if (has(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '"');
  };

  var define = function(bundle) {
    for (var key in bundle) {
      if (has(bundle, key)) {
        modules[key] = bundle[key];
      }
    }
  }

  globals.require = require;
  globals.require.define = define;
  globals.require.brunch = true;
})();

window.require.define({"Application": function(exports, require, module) {
  (function() {
    var Block, Channel, ChannelView, LayerManager, LayerView, MainRouter;

    MainRouter = require('routers/main_router').MainRouter;

    Channel = require('models/channel').Channel;

    Block = require('models/block').Block;

    LayerManager = require('views/layer_manager').LayerManager;

    LayerView = require('views/layer_view').LayerView;

    ChannelView = require('views/channel_view').ChannelView;

    exports.Application = (function() {

      function Application() {}

      Application.prototype.defaults = {};

      Application.prototype.initialize = function(options) {
        this.options = {};
        _.extend(this.options, options);
        this.layerManager = new LayerManager({
          el: $('#layers')
        });
        this.router = new MainRouter();
        return Backbone.history.start();
      };

      Application.prototype.addChannel = function(slug) {
        var channel, view;
        channel = new Channel(null, {
          slug: slug
        });
        view = new ChannelView({
          model: channel
        });
        return this.addLayer(view);
      };

      Application.prototype.addBlock = function(id) {
        var block, view;
        block = new Block({
          id: id
        });
        view = new BlockView(block);
        return this.addLayer(view);
      };

      Application.prototype.addLayer = function(content) {
        return this.layerManager.addLayer(content);
      };

      Application.prototype.setView = function(view) {
        this.contentView = view;
        this.contentView.render();
        return $('#content').html('').append(this.contentView.el);
      };

      return Application;

    })();

  }).call(this);
  
}});

window.require.define({"config/ApplicationConfig": function(exports, require, module) {
  
  /*
   * Application Configuration
   * 
   * @langversion CoffeeScript
   * 
   * @author 
   * @since
  */

  (function() {
    var ApplicationConfig;

    ApplicationConfig = (function() {

      function ApplicationConfig() {}

      ApplicationConfig.BASE_URL = "/";

      return ApplicationConfig;

    })();

    module.exports = ApplicationConfig;

  }).call(this);
  
}});

window.require.define({"events/ApplicationEvents": function(exports, require, module) {
  
  /*
   * Application Events
   * 
   * @langversion CoffeeScript
   * 
   * @author 
   * @since
  */

  (function() {
    var ApplicationEvents;

    ApplicationEvents = (function() {

      function ApplicationEvents() {}

      ApplicationEvents.APPLICATION_INITIALIZED = "onApplicationInitialized";

      return ApplicationEvents;

    })();

    module.exports = ApplicationConfig;

  }).call(this);
  
}});

window.require.define({"helpers/ViewHelper": function(exports, require, module) {
  
  /*
   * Handlebars Template Helpers
   * 
   * @langversion CoffeeScript
   * 
   * @author 
   * @since
  */

  /*//--------------------------------------
  //+ PUBLIC PROPERTIES / CONSTANTS
  //--------------------------------------
  */

  /*//--------------------------------------
  //+ PUBLIC METHODS / GETTERS / SETTERS
  //--------------------------------------
  */

  (function() {

    Handlebars.registerHelper('link', function(text, url) {
      var result;
      text = Handlebars.Utils.escapeExpression(text);
      url = Handlebars.Utils.escapeExpression(url);
      result = '<a href="' + url + '">' + text + '</a>';
      return new Handlebars.SafeString(result);
    });

  }).call(this);
  
}});

window.require.define({"initialize": function(exports, require, module) {
  
  /*
   * Application Initializer
   * 
   * @langversion CoffeeScript
   * 
   * @author 
   * @since
  */

  (function() {
    var Application;

    Application = require('Application').Application;

    $(function() {
      window.app = new Application;
      return window.app.initialize({
        rootChannel: "cambridge-book--2"
      });
    });

  }).call(this);
  
}});

window.require.define({"models/block": function(exports, require, module) {
  (function() {
    var __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    exports.Block = (function(_super) {

      __extends(Block, _super);

      function Block() {
        Block.__super__.constructor.apply(this, arguments);
      }

      return Block;

    })(Backbone.Model);

  }).call(this);
  
}});

window.require.define({"models/channel": function(exports, require, module) {
  (function() {
    var Block,
      __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    Block = require('models/block').Block;

    exports.Channel = (function(_super) {

      __extends(Channel, _super);

      function Channel() {
        Channel.__super__.constructor.apply(this, arguments);
      }

      Channel.prototype.model = Block;

      Channel.prototype.defaults = {
        depth: 0,
        autoload: true
      };

      Channel.prototype.url = function() {
        return "http://arena-cedar.herokuapp.com/api/v1/channels/" + this.options.slug + ".json?callback=?";
      };

      Channel.prototype.initialize = function(items, options) {
        this.options = _.extend(this.defaults, options);
        if (this.options.autoload) return this.loadBlocks(this.options.depth);
      };

      Channel.prototype.loadBlocks = function(depth) {
        var _this = this;
        if (depth == null) depth = 0;
        return this.fetch({
          success: function(channel, blocks) {
            _this.reset();
            _this.add(blocks.blocks);
            _this.add(blocks.channels);
            if (depth) {
              return _this.each(function(block) {
                if (block.get('block_type') === "Channel" && block.get('published')) {
                  return this.channel = new Channel(null, {
                    slug: block.get('slug'),
                    depth: channel.options.depth - 1
                  });
                }
              });
            }
          }
        });
      };

      return Channel;

    })(Backbone.Collection);

  }).call(this);
  
}});

window.require.define({"models/supers/Collection": function(exports, require, module) {
  
  /*
   * Base Class for all Backbone Collections
   * 
   * @langversion CoffeeScript
   * 
   * @author 
   * @since
  */

  (function() {
    var Collection,
      __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    module.exports = Collection = (function(_super) {

      __extends(Collection, _super);

      function Collection() {
        Collection.__super__.constructor.apply(this, arguments);
      }

      /*//--------------------------------------
      	//+ PUBLIC PROPERTIES / CONSTANTS
      	//--------------------------------------
      */

      /*//--------------------------------------
      	//+ INHERITED / OVERRIDES
      	//--------------------------------------
      */

      /*//--------------------------------------
      	//+ PUBLIC METHODS / GETTERS / SETTERS
      	//--------------------------------------
      */

      /*//--------------------------------------
      	//+ EVENT HANDLERS
      	//--------------------------------------
      */

      /*//--------------------------------------
      	//+ PRIVATE AND PROTECTED METHODS
      	//--------------------------------------
      */

      return Collection;

    })(Backbone.Collection);

  }).call(this);
  
}});

window.require.define({"models/supers/Model": function(exports, require, module) {
  
  /*
   * Base Class for all Backbone Models
   * 
   * @langversion CoffeeScript
   * 
   * @author 
   * @since
  */

  (function() {
    var Model,
      __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    module.exports = Model = (function(_super) {

      __extends(Model, _super);

      function Model() {
        Model.__super__.constructor.apply(this, arguments);
      }

      /*//--------------------------------------
      	//+ PUBLIC PROPERTIES / CONSTANTS
      	//--------------------------------------
      */

      /*//--------------------------------------
      	//+ INHERITED / OVERRIDES
      	//--------------------------------------
      */

      /*//--------------------------------------
      	//+ PUBLIC METHODS / GETTERS / SETTERS
      	//--------------------------------------
      */

      /*//--------------------------------------
      	//+ EVENT HANDLERS
      	//--------------------------------------
      */

      /*//--------------------------------------
      	//+ PRIVATE AND PROTECTED METHODS
      	//--------------------------------------
      */

      return Model;

    })(Backbone.Model);

  }).call(this);
  
}});

window.require.define({"routers/main_router": function(exports, require, module) {
  (function() {
    var Channel, ChannelView,
      __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    Channel = require('models/channel').Channel;

    ChannelView = require('views/channel_view').ChannelView;

    exports.MainRouter = (function(_super) {

      __extends(MainRouter, _super);

      function MainRouter() {
        MainRouter.__super__.constructor.apply(this, arguments);
      }

      MainRouter.prototype.routes = {
        "": "index",
        ":slug": "channel"
      };

      MainRouter.prototype.index = function() {
        return app.addChannel(app.options.rootChannel);
      };

      MainRouter.prototype.channel = function(slug) {
        return app.addChannel(slug);
      };

      return MainRouter;

    })(Backbone.Router);

  }).call(this);
  
}});

window.require.define({"utils/BackboneView": function(exports, require, module) {
  
  /*
   * View Description
   * 
   * @langversion CoffeeScript
   * 
   * @author 
   * @since
  */

  (function() {
    var BackboneView, View, template,
      __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    View = require('./supers/View');

    template = require('templates/HomeViewTemplate');

    module.exports = BackboneView = (function(_super) {

      __extends(BackboneView, _super);

      function BackboneView() {
        BackboneView.__super__.constructor.apply(this, arguments);
      }

      /*//--------------------------------------
      	//+ PUBLIC PROPERTIES / CONSTANTS
      	//--------------------------------------
      */

      BackboneView.prototype.id = 'view';

      BackboneView.prototype.template = template;

      /*//--------------------------------------
       	//+ INHERITED / OVERRIDES
       	//--------------------------------------
      */

      BackboneView.prototype.initialize = function() {
        return this.render = _.bind(this.render, this);
      };

      BackboneView.prototype.render = function() {
        this.$el.html(this.template(this.getRenderData()));
        return this;
      };

      BackboneView.prototype.getRenderData = function() {
        return {
          content: "View Content"
        };
      };

      /*//--------------------------------------
      	//+ PUBLIC METHODS / GETTERS / SETTERS
      	//--------------------------------------
      */

      /*//--------------------------------------
      	//+ EVENT HANDLERS
      	//--------------------------------------
      */

      /*//--------------------------------------
      	//+ PRIVATE AND PROTECTED METHODS
      	//--------------------------------------
      */

      return BackboneView;

    })(View);

  }).call(this);
  
}});

window.require.define({"views/HomeView": function(exports, require, module) {
  
  /*
   * View Description
   * 
   * @langversion CoffeeScript
   * 
   * @author 
   * @since
  */

  (function() {
    var HomeView, View, template,
      __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    View = require('./supers/View');

    template = require('./templates/HomeViewTemplate');

    module.exports = HomeView = (function(_super) {

      __extends(HomeView, _super);

      function HomeView() {
        HomeView.__super__.constructor.apply(this, arguments);
      }

      /*//--------------------------------------
      	//+ PUBLIC PROPERTIES / CONSTANTS
      	//--------------------------------------
      */

      HomeView.prototype.id = 'home-view';

      HomeView.prototype.template = template;

      /*//--------------------------------------
       	//+ INHERITED / OVERRIDES
       	//--------------------------------------
      */

      HomeView.prototype.initialize = function() {
        return this.render = _.bind(this.render, this);
      };

      HomeView.prototype.render = function() {
        this.$el.html(this.template(this.getRenderData()));
        return this;
      };

      HomeView.prototype.getRenderData = function() {
        return {
          content: "Application Content"
        };
      };

      /*//--------------------------------------
      	//+ PUBLIC METHODS / GETTERS / SETTERS
      	//--------------------------------------
      */

      /*//--------------------------------------
      	//+ EVENT HANDLERS
      	//--------------------------------------
      */

      /*//--------------------------------------
      	//+ PRIVATE AND PROTECTED METHODS
      	//--------------------------------------
      */

      return HomeView;

    })(View);

  }).call(this);
  
}});

window.require.define({"views/channel_view": function(exports, require, module) {
  (function() {
    var template,
      __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    template = require('./templates/channel');

    exports.ChannelView = (function(_super) {

      __extends(ChannelView, _super);

      function ChannelView() {
        ChannelView.__super__.constructor.apply(this, arguments);
      }

      ChannelView.prototype.events = {
        "click .block": "showBlock"
      };

      ChannelView.prototype.initialize = function() {
        this.template = template;
        return this.model.bind("add", this.render, this);
      };

      ChannelView.prototype.showBlock = function(e) {
        var block, id;
        id = parseInt(e.target.id);
        block = this.model.where({
          id: id
        })[0];
        if (block.get('block_type') === "Channel") {
          app.addChannel(block.get('slug'));
        } else {
          app.addBlock(block.id);
        }
        return false;
      };

      ChannelView.prototype.render = function() {
        return this.$el.html(this.template({
          blocks: this.model.toJSON()
        }));
      };

      return ChannelView;

    })(Backbone.View);

  }).call(this);
  
}});

window.require.define({"views/home_view": function(exports, require, module) {
  (function() {
    var homeTemplate,
      __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    homeTemplate = require('templates/home');

    exports.HomeView = (function(_super) {

      __extends(HomeView, _super);

      function HomeView() {
        HomeView.__super__.constructor.apply(this, arguments);
      }

      HomeView.prototype.id = 'home-view';

      HomeView.prototype.render = function() {
        $(this.el).html(homeTemplate());
        return this;
      };

      return HomeView;

    })(Backbone.View);

  }).call(this);
  
}});

window.require.define({"views/layer_manager": function(exports, require, module) {
  (function() {
    var LayerView,
      __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    LayerView = require('views/layer_view').LayerView;

    exports.LayerManager = (function(_super) {

      __extends(LayerManager, _super);

      function LayerManager() {
        LayerManager.__super__.constructor.apply(this, arguments);
      }

      LayerManager.prototype.initialize = function() {
        return this.layers = [];
      };

      LayerManager.prototype.addLayer = function(contentView) {
        var layer;
        layer = new LayerView({
          contentView: contentView,
          depth: this.layers.length
        });
        this.layers.push(layer);
        return this.render();
      };

      LayerManager.prototype.render = function() {
        var i, _ref, _results;
        _results = [];
        for (i = 0, _ref = this.layers.length - 1; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
          this.layers[i].render();
          _results.push(this.layers[i].$el.appendTo(this.$el));
        }
        return _results;
      };

      return LayerManager;

    })(Backbone.View);

  }).call(this);
  
}});

window.require.define({"views/layer_view": function(exports, require, module) {
  (function() {
    var template,
      __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    template = require('./templates/layer');

    exports.LayerView = (function(_super) {

      __extends(LayerView, _super);

      function LayerView() {
        LayerView.__super__.constructor.apply(this, arguments);
      }

      LayerView.prototype.attributes = {
        "class": "layer"
      };

      LayerView.prototype.events = {
        "click .close": "close"
      };

      LayerView.prototype.initialize = function() {
        this.template = template;
        return this.contentView = this.options.contentView;
      };

      LayerView.prototype.render = function() {
        this.$el.html(this.template());
        this.$el.append(this.contentView.render());
        return this.$el.css({
          top: this.options.depth * 50,
          zIndex: this.options.depth,
          backgroundColor: "hsl(250, 100%, " + (this.options.depth * 20 + 30) + "%)"
        });
      };

      LayerView.prototype.close = function() {
        return this.$el.remove();
      };

      return LayerView;

    })(Backbone.View);

  }).call(this);
  
}});

window.require.define({"views/menu_view": function(exports, require, module) {
  (function() {
    var template,
      __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    template = require('views/templates/menu');

    exports.MenuView = (function(_super) {

      __extends(MenuView, _super);

      function MenuView() {
        MenuView.__super__.constructor.apply(this, arguments);
      }

      MenuView.prototype.defaults = {
        depth: 1
      };

      MenuView.prototype.initialize = function() {
        _.extend(this.options, defaults);
        this.template = template;
        if (this.model.options.depth < this.options.depth) {
          return this.model.loadBlocks(depth);
        }
      };

      MenuView.prototype.render = function() {
        return this.$el.html(this.template({
          blocks: this.model.toJSON()
        }));
      };

      return MenuView;

    })(Backbone.View);

  }).call(this);
  
}});

window.require.define({"views/supers/View": function(exports, require, module) {
  
  /*
   * View Base Class
   * 
   * @langversion CoffeeScript
   * 
   * @author 
   * @since
  */

  (function() {
    var View,
      __hasProp = Object.prototype.hasOwnProperty,
      __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

    require('helpers/ViewHelper');

    module.exports = View = (function(_super) {

      __extends(View, _super);

      function View() {
        View.__super__.constructor.apply(this, arguments);
      }

      /*//--------------------------------------
      //+ PUBLIC PROPERTIES / CONSTANTS
      //--------------------------------------
      */

      View.prototype.template = function() {};

      View.prototype.getRenderData = function() {};

      /*//--------------------------------------
      //+ INHERITED / OVERRIDES
      //--------------------------------------
      */

      View.prototype.initialize = function() {
        return this.render = _.bind(this.render, this);
      };

      View.prototype.render = function() {
        this.$el.html(this.template(this.getRenderData()));
        this.afterRender();
        return this;
      };

      View.prototype.afterRender = function() {};

      /*//--------------------------------------
      //+ PUBLIC METHODS / GETTERS / SETTERS
      //--------------------------------------
      */

      /*//--------------------------------------
      //+ EVENT HANDLERS
      //--------------------------------------
      */

      /*//--------------------------------------
      //+ PRIVATE AND PROTECTED METHODS
      //--------------------------------------
      */

      return View;

    })(Backbone.View);

  }).call(this);
  
}});

window.require.define({"views/templates/channel": function(exports, require, module) {
  module.exports = function (__obj) {
    if (!__obj) __obj = {};
    var __out = [], __capture = function(callback) {
      var out = __out, result;
      __out = [];
      callback.call(this);
      result = __out.join('');
      __out = out;
      return __safe(result);
    }, __sanitize = function(value) {
      if (value && value.ecoSafe) {
        return value;
      } else if (typeof value !== 'undefined' && value != null) {
        return __escape(value);
      } else {
        return '';
      }
    }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
    __safe = __obj.safe = function(value) {
      if (value && value.ecoSafe) {
        return value;
      } else {
        if (!(typeof value !== 'undefined' && value != null)) value = '';
        var result = new String(value);
        result.ecoSafe = true;
        return result;
      }
    };
    if (!__escape) {
      __escape = __obj.escape = function(value) {
        return ('' + value)
          .replace(/&/g, '&amp;')
          .replace(/</g, '&lt;')
          .replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;');
      };
    }
    (function() {
      (function() {
        var block, _i, _len, _ref;
      
        __out.push('<ul class="channelView">\n\t');
      
        _ref = this.blocks;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          block = _ref[_i];
          __out.push('\n\t\t<li id="');
          __out.push(block.id);
          __out.push('" class="block ');
          __out.push(block.block_class);
          __out.push('">\n\t\t\t<div class="wrapper">\n\n\t\t        ');
          if (block.block_type === 'Image') {
            __out.push('\n\t\t          <!-- IMAGE -->\n\t\t          <img src="');
            __out.push(__sanitize(block.image.display));
            __out.push('" alt="');
            __out.push(__sanitize(block.title));
            __out.push('" />\n\t\t      \n\t\t        ');
          } else if (block.block_type === 'Link') {
            __out.push('\n\t\t          <!-- LINK -->\n\t\t          ');
            if (block.image.display) {
              __out.push('\n\t\t              <img src="');
              __out.push(__sanitize(block.image.display));
              __out.push('" alt="');
              __out.push(__sanitize(block.title));
              __out.push('" />\n\t\t          ');
            } else {
              __out.push('\n\t\t            <p>\n\t\t              <a href="');
              __out.push(__sanitize(block.link_url));
              __out.push('" class="external url" target="_blank">');
              __out.push(__sanitize(block.link_url));
              __out.push('</a>\n\t\t            </p>\n\t\t          ');
            }
            __out.push('\n\t\t      \n\t\t        ');
          } else if (block.block_type === 'Text') {
            __out.push('\n\t\t          <!-- TEXT -->\n\t\t          <div class="content">\n\t\t            ');
            __out.push(block.content);
            __out.push('\n\t\t          </div>\n\n\t\t        ');
          } else if (block.block_type === 'Channel' && block.published === true) {
            __out.push('\n\t\t          <!-- CHANNEL -->\n\t\t          ');
            __out.push(block.title);
            __out.push('\n\t\t        ');
          }
          __out.push('\n\t\t\t</div>\n\t\t</li>\n\t');
        }
      
        __out.push('\n</ul>');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  }
}});

window.require.define({"views/templates/layer": function(exports, require, module) {
  module.exports = function (__obj) {
    if (!__obj) __obj = {};
    var __out = [], __capture = function(callback) {
      var out = __out, result;
      __out = [];
      callback.call(this);
      result = __out.join('');
      __out = out;
      return __safe(result);
    }, __sanitize = function(value) {
      if (value && value.ecoSafe) {
        return value;
      } else if (typeof value !== 'undefined' && value != null) {
        return __escape(value);
      } else {
        return '';
      }
    }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
    __safe = __obj.safe = function(value) {
      if (value && value.ecoSafe) {
        return value;
      } else {
        if (!(typeof value !== 'undefined' && value != null)) value = '';
        var result = new String(value);
        result.ecoSafe = true;
        return result;
      }
    };
    if (!__escape) {
      __escape = __obj.escape = function(value) {
        return ('' + value)
          .replace(/&/g, '&amp;')
          .replace(/</g, '&lt;')
          .replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;');
      };
    }
    (function() {
      (function() {
      
        __out.push('<a class="close">&times;</a>');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  }
}});

window.require.define({"views/templates/menu": function(exports, require, module) {
  module.exports = function (__obj) {
    if (!__obj) __obj = {};
    var __out = [], __capture = function(callback) {
      var out = __out, result;
      __out = [];
      callback.call(this);
      result = __out.join('');
      __out = out;
      return __safe(result);
    }, __sanitize = function(value) {
      if (value && value.ecoSafe) {
        return value;
      } else if (typeof value !== 'undefined' && value != null) {
        return __escape(value);
      } else {
        return '';
      }
    }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
    __safe = __obj.safe = function(value) {
      if (value && value.ecoSafe) {
        return value;
      } else {
        if (!(typeof value !== 'undefined' && value != null)) value = '';
        var result = new String(value);
        result.ecoSafe = true;
        return result;
      }
    };
    if (!__escape) {
      __escape = __obj.escape = function(value) {
        return ('' + value)
          .replace(/&/g, '&amp;')
          .replace(/</g, '&lt;')
          .replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;');
      };
    }
    (function() {
      (function() {
        var block, _i, _len, _ref;
      
        __out.push('<ul>\n\t');
      
        _ref = this.blocks;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          block = _ref[_i];
          __out.push('\n\t\t');
          if (block.block_type === "Channel") {
            __out.push('\n\t\t\t<li class="menuItem">\n\t\t\t\t<a href="');
            __out.push(block.slug);
            __out.push('">');
            __out.push(block.title);
            __out.push('</a>\n\t\t\t</li>\n\t\t');
          }
          __out.push('\n\t');
        }
      
        __out.push('\n</ul>');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  }
}});

