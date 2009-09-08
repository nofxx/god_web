require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

GOD_LOG = "I [2009-09-08 02:50:33]  INFO: integra [ok] process is running (ProcessRunning)\nI [2009-09-08 02:50:42]  INFO: integra [ok] memory within bounds [23600kb, 23600kb, 23600kb, 23604kb, 23604kb] (MemoryUsage)"

describe "GodWeb" do

  it "should find possible statuses" do
    GodWeb.possible_statuses(:up).should eql(["stop", "restart", "unmonitor"])
  end

  it "should format log" do
    DRb.stub!(:start_service)
    God::Socket.stub!(:socket)
    DRbObject.should_receive(:new).and_return(mock_drb = mock("DRB"))
    mock_drb.should_receive(:ping).and_return(true)
    g = GodWeb.new("foo")
    g.send(:format_log, GOD_LOG).should eql( "<span class='gray'>02:50:33</span> | <span class='green'>ok</span> | process is running </br><span class='gray'>02:50:42</span> | <span class='green'>ok</span> | memory mb  [23, 23, 23, 23, 23] ")
  end
end

