var Store = require('flux/utils').Store;
var AppDispatcher = require('../dispatcher/dispatcher');
var TournamentStore = new Store(AppDispatcher);
var _tournaments = [];


TournamentStore.__onDispatch = function(payload) {
  switch(payload.actionType){
  case "TOURNAMENTS RECEIVED":
      resetTournaments(actionType.tournaments)
      TournamentStore.__emitChange();
      break;
  }
};

var resetTournaments = function(tournaments) {
  _tournaments = tournaments
};

Tournament.all = function() {
  tournaments.slice();
}

module.exports = TournamentStore;
