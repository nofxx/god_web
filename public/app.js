function submitCommand(action, watch) {
  var comm;
  if (action == "restart") {
    comm = "restart";
  } else {
    var act =  document.getElementById("toggle_" + action);
    var s = act.getAttribute("toggled");

    if(action == "power") {
      comm =  (s == "true") ? "start" : "stop";
    } else {
      comm =  (s == "true") ? "monitor" : "unmonitor";
    }
  }

  if (confirm("God will " +comm + " " + watch + "..")) {
    var res =  document.getElementById("command_result");
    iui.showPageByHref("/w/" + watch + "/" + comm, null, null, res, null);    //document.getElementById('lighting_form').submit();
  } else {
    act.setAttribute("toggled",  (s == "true") ? "false" : "true");
  }

}

