class PlayersController < ApplicationController

  before_action :set_player
  before_filter :normalize_step, only: [:play, :do_play]
  layout 'application_smart_phone'

  def show
    @is_redirected = params[:is_redirected] == 'true'
    render
  end

  def play
    render
  end

  def do_play
    if (d = params[:decision].try(:to_i))
      @pl.decide(@step, d)
      logger.info "[play] Player(#{@pl.id}) decide Q(#{@step}) <- A(#{d})"
    end
    redirect_to play_player_path(@pl, @step)
  end

  private

  def set_player
    @pl = Player.with_play.find(params[:id])
    @step = params[:step].try(&:to_i)
  end

  def normalize_step
    unless @pl.play.started?
      redirect_to player_path(@pl) + '?is_redirected=true'
      return false
    end
    @step = params[:step].to_i
    if @step > @pl.play.step
      redirect_to play_player_path(@pl, @pl.play.step)
      return false
    end
  end

end

