var React = require('react');
var Paginator = require('react-js-pagination').default;
var PlayerStore = require('../stores/player');
var ApiUtil = require('../util/api_util');

var PlayerIndex = React.createClass( {
  getInitialState: function() {
    return {
      players: PlayerStore.all(),
      activePage: 1,
      playerPos: 0
    };
  },

  componentDidMount: function() {
    this.playerToken = PlayerStore.addListener(this._playerOnChange);
    ApiUtil.fetchPlayers();
  },

  componentWillUnmount: function() {
    this.playerToken.remove();
  },

  handlePageChange(pageNumber) {
    this.setState({activePage: pageNumber, playerPos: 20*(pageNumber-1)});
  },

  _playerOnChange: function() {
    this.setState( {players: PlayerStore.all()} )
  },

  render: function() {
    var players = []

    for (var i = this.state.playerPos; i < this.state.players.length && i < this.state.playerPos + 20; i++) {
      players.push(<li className="player-list" key={i}>
      <ul>
        <li>
          {this.state.players[i].tag}
        </li>
        <li>
          {this.state.players[i].skill}
        </li>
        <li>
          {this.state.players[i].confidence_low}
        </li>
        <li>
          {this.state.players[i].confidence_high}
        </li>
      </ul>
    </li>
      );
    }
    if(this.state.players.length > 0){
      return (
        <div>
          <ul>
            {players}
          </ul>
            <Paginator
              activePage={this.state.activePage}
              itemsCountPerPage={20}
              totalItemsCount={this.state.players.length}
              pageRangeDisplayed={5}
              onChange={this.handlePageChange}
            />
        </div>
      );
    }
    else {
      return (
        <div>
        </div>
      )
    }
  }
});

module.exports = PlayerIndex;
