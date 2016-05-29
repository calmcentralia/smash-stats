var Store = require('flux/utils').Store;
var AppDispatcher = require('../dispatcher/dispatcher');
var TournamentStore = new Store(AppDispatcher);
var _tournaments = [];


TournamentStore.__onDispatch = function(payload) {
  switch(payload.actionType){
  case "TOURNAMENTS RECEIVED":
      resetTournaments(payload.tournaments)
      TournamentStore.__emitChange();
      break;
  }
};

var resetTournaments = function(tournaments) {
  _tournaments = tournaments
};

TournamentStore.all = function() {
  return _tournaments.slice();
}

module.exports = TournamentStore;
