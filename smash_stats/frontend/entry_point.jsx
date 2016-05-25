var React = require('react');
var ReactDOM = require('react-dom');
var ReactRouter = require('react-router');
var Router = ReactRouter.Router;
var Route = ReactRouter.Route;
var IndexRoute = ReactRouter.IndexRoute;

var App = React.createClass({
  render: function() {
    return (
      <div className="page">
        <header>
         </header>
        {this.props.children}
      </div>
    );
  }
});

var routes = (
  <Route path="/" component={App}>
    <IndexRoute component={Splash}/>
  </Route>
);

document.addEventListener("DOMContentLoaded", function() {
  var root = document.getElementById("content");
  ReactDOM.render(<Router>{routes}</Router>, root);
});
