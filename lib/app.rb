before do
  unless (GODWEB_CONFIG['username'].nil? && GODWEB_CONFIG['password'].nil?) || self.request.path_info == '/heartbeat'
    use Rack::Auth::Basic do |user, pass|
      [user, pass] == [GODWEB_CONFIG['username'], GODWEB_CONFIG['password']]
    end
  end
  GODWEB.ping
end

get '/' do
  @statuses = GODWEB.status
  @watches = []
  @statuses.each do |watch, status|
    @watches << watch.to_s
  end
  @watches.sort!
  @groups = GODWEB.groups
  @host = `hostname`
  @stats = GodWeb.cpu_status
  @footer = "GodWeb v0.2 - #{@host}"
  show(:status, @host)
end

get '/w/:watch' do
  @watch = params["watch"]
  @status = GODWEB.status[@watch][:state]
  @commands = GodWeb.possible_statuses(@status)
  @log = GODWEB.last_log(@watch)
  show(:watch, @watch)
end

get '/g/:group' do
  @watch = @group = params["group"]
  @child = GODWEB.status.keys.each.select { |k| GODWEB.status[k][:group] == @group } #.select { |w| w["group"] = @group }
  @child.map!{ |c| [c, GODWEB.status[c][:state]]}
  @status = nil
  @commands = GodWeb.possible_statuses(@status)
  show(:watch, "#{@group} [group]")
end

get '/w/:watch/:command' do
  @watch = params["watch"]
  @command = params["command"]
  @success = GODWEB.send(@command, @watch)
  @success = false if @success == []
  @log = GODWEB.last_log(@watch)
  show(:command, "#{@command}ing #{@watch}")
end

get '/o' do
  @commands = %w{ true }
  show(:watch, "god itself")
end

get '/i' do
  @text = `hostname`
  show(:icon)
end

get '/heartbeat' do
  @statuses = GODWEB.status
  'OK'
end

private

def show(template, title = 'GodWeb')
  @title = title
  erb(template)
end
