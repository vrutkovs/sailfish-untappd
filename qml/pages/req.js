.pragma library

function request(method, url, opts, callback) {
  var xhr = new XMLHttpRequest;

  xhr.onreadystatechange = function() {
    if (xhr.readyState != XMLHttpRequest.DONE) return;

    var response = xhr.responseText;
    var contentType = xhr.getResponseHeader('content-type');
    if (contentType.match(/application\/json/))
      response = JSON.parse(response);

    xhr.response = response;

    callback(null, xhr);
  };

  xhr.open(method, url);
  xhr.send();
  return xhr;
}

function get(url, opts, callback) {
  if (typeof opts == 'function') {
    callback = opts;
    opts = {};
  }

  return request('GET', url, opts, callback);
}
