var Store = require('flux/utils').Store
var AppDispatcher = require('../dispatcher/dispatcher');
var NewsStore = new Store(AppDispatcher);
var _news = [];

NewsStore.__onDispatch = function(payload) {
  switch(payload.actionType) {
  case "NEWS RECEIVED":
    resetNews(payload.news);
    NewsStore.__emitChange();
    break;
  }
}

var resetNews = function(news) {
  _news = news;
}


NewsStore.recent = function() {
  return _news.slice(0, 5);
}

NewsStore.all = function() {
  return _news.slice();
}

module.exports = NewsStore;
