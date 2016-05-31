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

  tournamentUpdate: function(title) {
    $.ajax({
      url: "api/challonge",
      method: "PATCH",
      data: title
    });
  }
};

module.exports = ApiUtil;
