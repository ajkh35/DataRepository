class UsersController < ApplicationController

  before_action :authorize, :except => [:new,:create]
  respond_to :js, :html

  def new
    if logged_in?
      redirect_to user_path(get_current_user)
    else
  	 @user = User.new
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		login(@user)
  		redirect_to controller: 'users',action: 'show',id: get_current_user.id,token: 'dashboard'
  		flash[:notice] = "Successfully created account"
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to controller: 'users',action: 'show',id: get_current_user.id,token: 'dashboard'
      flash[:notice] = "Updated details"
    else
      render 'edit'
    end
  end

  def show
  	@user = User.find(params[:id])
    @menuOption = params[:token]
    @songs, @movies, @games, @documents = nil, nil, nil, nil
    $loaded = 0
    if verify_user(@user)
      if @menuOption=='dashboard'
        dashboard(@user)
      elsif @menuOption=='music'
        @songs = Music.where(user_id: @user.id).limit(4)
        @hasMoreMusic = has_more(@songs,'music')
      elsif @menuOption=='movies'
        @movies = Movie.where(user_id: @user.id).limit(4)
        @hasMoreMovies = has_more(@movies,'movies')
      elsif @menuOption=='games'
        @games = Game.where(user_id: @user.id).limit(4)
        @hasMoreGames = has_more(@games,'games')
      else
        # Get documents here
      end
    else
      redirect_to user_path(get_current_user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    log_out
    redirect_to root_url
    flash[:alert] = "Your account has been deleted permanently."
  end

  def confirm_delete
    @user = User.find(params[:id])
  end

# Get dashboard contents from database
  def dashboard(user)
    @songs = Music.where(user_id: user.id).limit(4)
    @hasMoreMusic = has_more(@songs,'music')
    @movies = Movie.where(user_id: user.id).limit(4)
    @hasMoreMovies = has_more(@movies,'movies')
    @games = Game.where(user_id: user.id).limit(4)
    @hasMoreGames = has_more(@games,'games')
  end

# Know if there are more objects on page load
  def has_more(object,category)
    if category=='music'
      songs = Music.where(user_id: get_current_user.id).limit(5)
      return (songs.count-object.count) > 0
    elsif category=='movies'
      movies = Movie.where(user_id: get_current_user.id).limit(5)
      return (movies.count-object.count) > 0
    elsif category=='games'
      games = Game.where(user_id: get_current_user.id).limit(5)
      return (games.count-object.count) > 0 
    else
    end
  end

# Get more items on button click
  def get_more

    # Get load offset
    if $loaded>0
      loaded = $loaded
    else
      loaded = 4
    end

    @category = params[:category]

    # Query new objects
    if params[:category] == 'music'
      @songs = Music.where(user_id: get_current_user.id).offset(loaded).limit(4)
      if((Music.where(user_id: get_current_user.id).offset(loaded).count - @songs.count) > 0)
        @hasMore = true
        $loaded = loaded + @songs.count
      else
        @hasMore = false
        $loaded = 0
      end
    elsif params[:category]=='movies'
      @movies = Movie.where(user_id: get_current_user.id).offset(loaded).limit(4)
      if((Movie.where(user_id: get_current_user.id).offset(loaded).count - @movies.count) > 0)
        @hasMore = true
        $loaded = loaded + @movies.count
      else
        @hasMore = false
        $loaded = 0
      end
    elsif params[:category]=='games'
      @games = Game.where(user_id: get_current_user.id).offset(loaded).limit(4)
      if((Game.where(user_id: get_current_user.id).offset(loaded).count - @games.count) > 0)
        @hasMore = true
        $loaded = loaded + @games.count
      else
        @hasMore = false
        $loaded = 0
      end
    else
      # documents go here 
    end
  end

  private
  def user_params
  	params.require(:user).permit(:email,
                          :password,:password_confirmation,
                          :avatar,
                          :user_name,
                          :first_name,:last_name)
  end

  def verify_user(user)
    if get_current_user.id == user.id
      return true
    else
      return false
    end
  end
end