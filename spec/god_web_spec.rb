require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

GOD_RUN = "I [2009-09-08 02:50:33]  INFO: integra [ok] process is running (ProcessRunning)\n"
GOD_MEM = "I [2009-09-08 02:50:42]  INFO: integra [ok] memory within bounds [23600kb, 23600kb, 23600kb, 23604kb, 23604kb] (MemoryUsage)"
GOD_MOV = "I [2009-09-08 05:06:19]  INFO: nginx move 'up' to 'restart'"
GOD_ACT = "I [2009-09-08 05:06:19]  INFO: nginx restart: /etc/rc.d/nginx restart"

describe "GodWeb" do

  it "should find possible statuses" do
    GodWeb.possible_statuses(:up).should eql([true, true]) #["stop", "restart", "unmonitor"])
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
      "<span class='gray'>02:50:42</span> | <span class='green'>ok</span> | mem mb  [23, 23, 23, 23, 23] " )
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

  # bad emacs ruby highlight.. =/
  it "should find out used/free cpu" do
  #  GodWeb.stub(:`).and_return("cpu  6528133 751 1130715 31204523 214784 3694 21914 0 0\ncpu0 3230410 558 557722 15169049 107745 1743 9792 0 0\ncpu1 3297722 193 572992 16035473 107039 1950 12122 0 0\nintr 655758766 681 2 0 0 0 0 3 0 1368 0 0 0 0 0 0 0 0 0 0 0 0 0 4141444 0 0 0 0 4137248 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0\nctxt 1580587936\nbtime 1252305746\nprocesses 438409\nprocs_running 6\nprocs_blocked 0\n")
    GodWeb.cpu_status.should eql(["6499", "1485", "20"])
  end

  it "should find out used/free ram" do
    GodWeb.stub(:`).and_return("             total       used       free     shared    buffers     cached\nMem:          7984       6499       1485          0        265       3480\nSwap:         7632         20       7611\n")
    GodWeb.ram_status.should eql(["6499", "1485", "3480", "20"])
  end

end

