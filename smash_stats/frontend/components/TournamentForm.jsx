var React = require('react');
var ApiUtil = require('../util/api_util');
var LinkedStateMixin = require('react-addons-linked-state-mixin');
var hashHistory = require('react-router').hashHistory;

var TournamentForm = React.createClass( {
  mixins: [LinkedStateMixin],

  getInitialState: function() {
    return {titles: ""};
  },
  handleSubmit: function() {
    ApiUtil.tournamentUpdate({titles: this.state.titles});
  },

  render: function() {
    return (
      <div>
        <form onSubmit={this.handleSubmit}>
          <input type="text" valueLink={this.linkState('titles')}/>
          <input type="submit" value="Add Tournament" />
        </form>
      </div>
    );
  }

});

module.exports = TournamentForm;
