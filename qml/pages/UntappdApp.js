.import "settings.js" as Settings

var userkey;

var UT_CLIENT_ID = "7E07FC9AC3B3866F4F620819996F262F087EAC92";
var UT_CLIENT_SECRET = "8CE5E863B1CC5C9B69820BF39717302135582D9A";

function isLoggedIn() {
  userkey = Settings.readSetting("userkey");
  return !!userkey;
}

var oauthReturnUrl = "sailfishuntappd://oath_return"
var oauthLoginUrl = "https://untappd.com/oauth/authenticate/?client_id=" + UT_CLIENT_ID + "&response_type=code&redirect_url=" + oauthReturnUrl;
