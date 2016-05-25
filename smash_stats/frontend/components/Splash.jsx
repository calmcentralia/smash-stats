var React = require('react');
var ApiUtil = require('../util/api_util');
var hashHistory = require('react-router').hashHistory;
var TournamentStore = require('../stores/tournament');
var NewsStore = require('../stores/news');
var Splash = React.createClass( {
  getInitialState: function() {
    return {
      recentTournamentsAdded: [],
      news: NewsStore.all()
    };
  },

  componentDidMount: function() {
    this.tournamentToken = TournamentStore.addListener(this._tournamentOnChange);
    this.newsToken = NewsStore.addListener(this._newsOnChange);
    ApiUtil.fetchTournaments( { flag: "recent" } );
    if (this.state.news.length === 0) {
      ApiUtil.fetchNews();
    }
  },

  _tournamentOnChange: function() {
    this.setState( { recentTournamentsAdded: TournamentStore.all() });
  },

  _newsOnChange: function() {
    this.setState( {news: NewsStore.all()});
  },

  render: function() {
    var recentTournamets = []
    var recentNews = []
    for (var i = 0; i < this.state.recentTournamentsAdded.length; i++) {
      recentTournamets.push(<li className="tournament-list" id={this.state.recentTournamentsAdded.id} key={i} onClick={this.handleClick}>
      {this.state.recentTournamentsAdded[i].title}
      <br/>
      {this.state.recentTournamets.updated_at}
      </li>
      );
    }

    for (var i = 0; i < this.state.news.length; i++) {
      recentNews.push(
        <li className="headline" key={i}>
          {this.state.news[i].headline}
        </li>
        <li className="body" key={i}>
        {this.state.news[i].body}
        </li>
      );
    }
    return(
        <div>
          <div>
            Calm's Smash Stats
          </div>
          <div>
            <ul className="news">
              {recentNews}
            </ul>
          </div>
          <div>
            <ul className="tournaments">
              {recentTournamets}
            </ul>
          </div>
        </div>
      );
    }
  });

module.exports = Splash;
