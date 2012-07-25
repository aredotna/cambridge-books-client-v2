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
      
        __out.push('<ul id="channelView">\n\t');
      
        _ref = this.blocks;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          block = _ref[_i];
          __out.push('\n\t\t<li class="block ');
          __out.push(block.block_class);
          __out.push('">\n\t\t\t<div class="wrapper">\n\n\t\t        ');
          if (block.block_type === 'Image') {
            __out.push('\n\t\t          <!-- IMAGE -->\n\t\t          <img src="');
            __out.push(__sanitize(block.image.display));
            __out.push('" alt="');
            __out.push(__sanitize(block.title));
            __out.push('" />\n\t\t      \n\n\t\t        ');
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
            __out.push('\n\t\t      \n\n\t\t        ');
          } else if (block.block_type === 'Text') {
            __out.push('\n\t\t          <!-- TEXT -->\n\t\t          <div class="content">\n\t\t            ');
            __out.push(block.content);
            __out.push('\n\t\t          </div>\n\t\t      \n\n\t\t        ');
          } else if (block.block_type === 'Channel' && block.published === true) {
            __out.push('\n\t\t          <!-- CHANNEL -->\n\t\t          <a href="#/');
            __out.push(__sanitize(block.slug));
            __out.push('">');
            __out.push(block.title);
            __out.push('</a>\n\t\t        ');
          }
          __out.push('\n\n\n\t\t\t</div>\n\t\t</li>\n\t');
        }
      
        __out.push('\n</ul>');
      
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

