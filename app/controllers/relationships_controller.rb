class RelationshipsController < ApplicationController
  def create
    current_user.relationships.create(relation_params)
  end

  def destroy
    current_user.relationships.find_by(followed_id: relation_params[:followed_id]).destroy
  end

  private 
  def relation_params
    params.require(:relation).permit(:followed_id)
  end
end
