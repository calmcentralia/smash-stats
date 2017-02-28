var React = require('react');
var Paginator = require('react-js-pagination').default;
var PlayerStore = require('../stores/player');
var ApiUtil = require('../util/api_util');
var SearchBar = require('../components/SearchBar');

var PlayerIndex = React.createClass( {
  getInitialState: function() {
    return {
      players: PlayerStore.all(),
      activePage: 1,
      playerPos: 0,
      sortCategory: "none"
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
    this.setState({activePage: pageNumber, playerPos: 10*(pageNumber-1)});
  },

  _playerOnChange: function() {
    this.setState( {players: PlayerStore.all()} )
  },

  handleSort: function(e) {
    var players = JSON.parse(JSON.stringify(this.state.players));
    var sortCategory = this.state.sortCategory;
    switch(e.currentTarget.className) {
      case "head-cell tag":
        if (sortCategory === "tag") {
          sortCategory = "none";
          players.sort(function(a, b) {
            var nameA = a.tag.toUpperCase(); // ignore upper and lowercase
            var nameB = b.tag.toUpperCase(); // ignore upper and lowercase
            if (nameA < nameB) {
              return 1;
            }
            if (nameA > nameB) {
              return -1;
            }
            return 0;
          });
        } else {
          sortCategory = "tag";
          players.sort(function(a, b) {
            var nameA = a.tag.toUpperCase(); // ignore upper and lowercase
            var nameB = b.tag.toUpperCase(); // ignore upper and lowercase
            if (nameA < nameB) {
              return -1;
            }
            if (nameA > nameB) {
              return 1;
            }
            return 0;
          });
        }
        break;

      case "head-cell skill-rating":
        if (sortCategory === "skill-rating") {
          sortCategory = "none";
          players.sort(function(a,b) {
            return b.skill - a.skill;
            });
          }
        else {
          sortCategory = "skill-rating";
          players.sort(function(a,b) {
            return a.skill - b.skill;
          });
        }
        break;

        case "head-cell interval":
          if (sortCategory === "interval") {
            sortCategory = "none";
            players.sort(function(a, b) {
              return b.confidence_high - a.confidence_high;
            });
          } else {
            sortCategory = "interval";
            players.sort(function(a,b) {
              return a.confidence_low - b.confidence_low;
            });
          }
          break;
    }
    this.setState( {players: players, sortCategory: sortCategory} );
  },

  handleResults: function(results) {
    this.setState({ players: results, activePage: 1, playerPos: 0, sortCategory: "none" });
  },

  render: function() {
    var players = []
    var oddEven = "odd"
    for (var i = this.state.playerPos; i < this.state.players.length && i < this.state.playerPos + 10; i++) {
      if(i%2 === 1) {
        oddEven = "odd"
      }
      else{
        oddEven = "even"
      }
      players.push(<div className={"row " + oddEven} key={i}>
        <div className="cell">
          {this.state.players[i].tag}
        </div>
        <div className="cell">
          {this.state.players[i].skill}
        </div>
        <div className="cell">
          {this.state.players[i].confidence_low} - {this.state.players[i].confidence_high}
        </div>
      </div>
      );
    }
    if(this.state.players.length > 0){
      return (
        <div>
          <SearchBar
            onChange={this.handleResults}
            />
          <div className='head'>
            <div className="head-cell tag" onClick={this.handleSort}>
            Tag
            </div>
            <div className="head-cell skill-rating" onClick={this.handleSort}>
            Skill Rating
            </div>
            <div className="head-cell interval" onClick={this.handleSort}>
            95% Certainty Interval
            </div>
          </div>
            {players}
            <Paginator
              activePage={this.state.activePage}
              itemsCountPerPage={10}
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
        <SearchBar
          onChange={this.handleResults}
          />
        </div>
      )
    }
  }
});

module.exports = PlayerIndex;
