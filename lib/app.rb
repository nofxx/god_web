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
  show(:status)
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

get '/heartbeat' do
  @statuses = GODWEB.status
  'OK'
end

private

def show(template, title = 'GodWeb')
  @title = title
  erb(template)
end
