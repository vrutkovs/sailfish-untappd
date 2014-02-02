.import "settings.js" as Settings
.import "req.js" as Req
.import "keys.js" as Keys

var userkey;

var token = (function() {
  var token;
  return function() {
    if (!token) token = Settings.get("ut_access_token");
    return token;
  }
})();

function isLoggedIn() {
  userkey = Settings.get("ut_access_token");
  return !!userkey;
}

var oauthReturnUrl = "http://sailfish_untappd_oath_return";
var oauthLoginUrl = "https://untappd.com/oauth/authenticate/?client_id=" + Keys.UT_CLIENT_ID + "&response_type=code&redirect_url=" + encodeURIComponent(oauthReturnUrl);
var oauthAuthorizeUrlRoot = "https://untappd.com/oauth/authorize/?client_id=" + Keys.UT_CLIENT_ID + "&client_secret=" + Keys.UT_CLIENT_SECRET + "&response_type=code&redirect_url=" + encodeURIComponent(oauthReturnUrl) + "&code=";

function isReturnUrl(urlString) {
  var regex = new RegExp("^" + oauthReturnUrl.replace(/\//g, '\\/'));
  return !!regex.exec(urlString);
}

function authenticateUserKey(url, callback) {
  var codeExtract = url.toString().match(/code=([\w\d]+)(&|$)/);
  if (!codeExtract || !codeExtract[1]) return callback(new Error("Couldn't extract code from url" + url));
  var code = codeExtract[1];

  Req.get(oauthAuthorizeUrlRoot + code, function(err, xhr) {
    if (xhr.status > 400) return callback(xhr.statusText + " " + xhr.response);
    Settings.set("ut_access_token", xhr.response.response.access_token);
    callback();
  });
}


function api(path, opts, callback) {
  if (typeof opts == 'function') {
    callback = opts;
    opts = {};
  }

  var url = 'http://api.untappd.com' + path;

  opts.access_token = token();
  opts.client_secret = Keys.UT_CLIENT_SECRET;
  opts.client_id = Keys.UT_CLIENT_ID;

  Object.keys(opts).forEach(function(key, i) {
    url += i ? '&' : '?';
    url += key + '=' + encodeURIComponent(opts[key]);
  });

  Req.get(url, function(err, xhr) {
    if (err) return callback(err);
    callback(null, xhr.response.response);
  });
}
