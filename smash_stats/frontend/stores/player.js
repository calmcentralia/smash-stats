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

module.exports = PlayerStore;
