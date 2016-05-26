var Actions = require('../actions/actions.js');

var APiUtil = {
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
      success: function(tournaments) {
        Actions.receiveTournaments(tournaments);
      }
    });
  }
};

module.exports = ApiUtil;
