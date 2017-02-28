var Store = require('flux/utils').Store;
var AppDispatcher = require('../dispatcher/dispatcher');
var PlayerStore = new Store(AppDispatcher);
var _players = [];


PlayerStore.__onDispatch = function(payload) {
  switch(payload.actionType){
  case "PLAYERS RECEIVED":
      resetPlayers(payload.players)
      PlayerStore.__emitChange();
      break;
  }
};

var resetPlayers = function(players) {
  _players = players
};

PlayerStore.all = function() {
  return _players.slice();
}

PlayerStore.tags = function() {
  var search = [];
  for (var i = 0; i < _players.length; i++) {
    search.push(_players[i].tag);
  }
  return search;
};

PlayerStore.findByTag = function(tags) {
  var matches = [];
  for (var i = 0; i < tags.length; i++) {
    for (var j = 0; j < _players.length; j++) {
      if(tags[i] === _players[j].tag) {
        matches.push(_players[j]);
      }
    }
  }
  return matches;
};

module.exports = PlayerStore;
