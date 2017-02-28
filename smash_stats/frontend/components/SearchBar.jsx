var React = require('react');
var ApiUtil = require('../util/api_util');
var LinkedStateMixin = require('react-addons-linked-state-mixin');
var PlayerStore = require('../stores/player');
var fuzzy = require('fuzzy');


var SearchBar = React.createClass({
  mixins: [LinkedStateMixin],
  getInitialState: function(){
    return {
      allItems: PlayerStore.tags(),
      matches: []
    };
  },

  componentDidMount: function() {
    this.playerToken = PlayerStore.addListener(this._playerOnChange);
  },

  componentWillUnmount: function() {
    this.playerToken.remove();
  },

  _playerOnChange: function() {
    this.setState({ allItems: PlayerStore.tags() });
  },

  getResults: function(e) {
    var results = fuzzy.filter(e.target.value, this.state.allItems);
    var matches = [];
    if(e.target.value === ""){
      matches = PlayerStore.all();
      this.setState({ matches: matches });
    } else {
      matches = PlayerStore.findByTag(results.map(function(el) {return el.string;}));
      this.setState( { matches: matches} );
    }
    this.props.onChange(matches);
  },

  render: function() {
    return(
    <div className="search-box">
      <input className="search-bar" type="search" placeholder="search players by tag" onChange={this.getResults}>
      </input>
    </div>
  );
  }
});

module.exports = SearchBar;
