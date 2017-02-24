var AppDispatcher = require('../dispatcher/dispatcher');

var Actions = {
  receiveNews: function(news){
    AppDispatcher.dispatch({
      actionType: "NEWS RECEIVED",
      news: news
    });
  },

  receiveTournaments: function(tournaments){
    AppDispatcher.dispatch({
      actionType: "TOURNAMENTS RECEIVED",
      tournaments: tournaments
    });
  },

  receivePlayers: function(players){
    AppDispatcher.dispatch({
      actionType: "PLAYERS RECEIVED",
      players: players
    });
  }
};

module.exports = Actions;
