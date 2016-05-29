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
      success: function(tournaments) {
        debugger
        Actions.receiveTournaments(tournaments);
      }
    });
  }
};

module.exports = ApiUtil;
