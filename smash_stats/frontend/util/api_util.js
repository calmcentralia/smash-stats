var Actions = require('../actions/actions.js');

var ApiUtil = {
  fetchNews: function() {
    $.ajax({
      url: "api/news",
      method: "GET",
      success: function(news) {
        Actions.receiveNews(news);
      }
    });
  },

  fetchTournaments: function(flag) {
    $.ajax({
      url: "api/tournaments",
      method: "GET",
      data: flag,
      success: function(tournaments) {
        Actions.receiveTournaments(tournaments);
      }
    });
  },

  fetchPlayers: function() {
    $.ajax({
      url: "api/players",
      method: "GET",
      success: function(players) {
        Actions.receivePlayers(players);
      }
    });
  },

  tournamentUpdate: function(titles) {
    $.ajax({
      url: "api/challonge",
      method: "PATCH",
      data: titles
    });
  }
};

module.exports = ApiUtil;
