var React = require('react');
var ApiUtil = require('../util/api_util');
var hashHistory = require('react-router').hashHistory;
var TournamentStore = require('../stores/tournament');
var NewsStore = require('../stores/news');
var Splash = React.createClass( {
  getInitialState: function() {
    return {
      recentTournamentsAdded: [],
      news: NewsStore.recent()
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

  componentWillUnmount: function() {
    this.tournamentToken.remove();
    this.newsToken.remove();
  },

  _tournamentOnChange: function() {

    this.setState( { recentTournamentsAdded: TournamentStore.all() });
  },

  _newsOnChange: function() {
    this.setState( {news: NewsStore.recent()});
  },

  render: function() {
    var recentTournaments = []
    var recentNews = []

    for (var i = 0; i < this.state.recentTournamentsAdded.length; i++) {
      recentTournaments.push(<li className="tournament-list" id={this.state.recentTournamentsAdded.id} key={i} onClick={this.handleClick}>
      {this.state.recentTournamentsAdded[i].title}
      <br/>
      {this.state.recentTournamentsAdded[i].updated_at}
      </li>
      );
    }

    for (var i = 0; i < this.state.news.length; i++) {
      recentNews.push(
        <li className="headline" key={2*i}>
          {this.state.news[i].headline}
        </li>);
      recentNews.push(
        <li className="body" key={2*i+1}>
          {this.state.news[i].body}
        </li>);
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
              {recentTournaments}
            </ul>
          </div>
        </div>
      );
    }
  });

module.exports = Splash;
