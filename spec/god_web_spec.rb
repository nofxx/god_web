require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

GOD_RUN = "I [2009-09-08 02:50:33]  INFO: integra [ok] process is running (ProcessRunning)\n"
GOD_MEM = "I [2009-09-08 02:50:42]  INFO: integra [ok] memory within bounds [23600kb, 23600kb, 23600kb, 23604kb, 23604kb] (MemoryUsage)"
GOD_MOV = "I [2009-09-08 05:06:19]  INFO: nginx move 'up' to 'restart'"
GOD_ACT = "I [2009-09-08 05:06:19]  INFO: nginx restart: /etc/rc.d/nginx restart"

describe "GodWeb" do

  it "should find possible statuses" do
    GodWeb.possible_statuses(:up).should eql(["stop", "restart", "unmonitor"])
  end

  describe "Log formatter" do
    before do
      DRb.stub!(:start_service)
      God::Socket.stub!(:socket)
      DRbObject.should_receive(:new).and_return(mock_drb = mock("DRB"))
      mock_drb.should_receive(:ping).and_return(true)
      @g = GodWeb.new("foo")
    end

    it "should format log" do
      @g.send(:format_log, GOD_RUN).should eql(
      "<span class='gray'>02:50:33</span> | <span class='green'>ok</span> | process is running " )
    end

    it "should format log mem" do
      @g.send(:format_log, GOD_MEM).should eql(
      "<span class='gray'>02:50:42</span> | <span class='green'>ok</span> | memory mb  [23, 23, 23, 23, 23] " )
    end

    it "should format log move" do
      @g.send(:format_log, GOD_MOV).should eql(
       "<span class='gray'>05:06:19</span> | <span class='act'>act</span> | move 'up' to 'restart'" )
    end

    it "should format log act" do
      @g.send(:format_log, GOD_ACT).should eql(
       "<span class='gray'>05:06:19</span> | <span class='act'>act</span> | restart: /etc/rc.d/nginx restart" )
    end

  end

end

