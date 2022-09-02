class ProfilesController < ApplicationController

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])

    if @profile.update(profile_params)

      if profile_params[:avatar]
        @profile.avatar.attach(profile_params[:avatar])
      end

      if profile_params[:banner]
        @profile.banner.attach(profile_params[:banner])
      end
      
      redirect_to @profile.user 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:bio, :first_name, :last_name, :avatar, :banner)
  end
end
