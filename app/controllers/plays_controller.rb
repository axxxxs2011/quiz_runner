class PlaysController < ApplicationController
  def index
    @qs = Quiz.select(:id, :title).all
    @ps = Play.all
    render
  end

  def create
    Play.create! do |p|
      q = Quiz.find(params[:quiz_id])
      p.data = q.questions
      p.memo = params[:memo]
    end
    redirect_to plays_path
  end

  def show
    @p = Play.find(params[:id])
    render
  end

  def create_player
    p = Play.find(params[:id])
    p.players.create! do |pl|
      pl.name = params[:name]
    end
    redirect_to play_path(p)
  end

  def play
    @p = Play.find(params[:id])
    @step = get_step
    render
  end

  def do_play
    @p = Play.find(params[:id])
    step = get_step

    if @p.step == 0
      @p.next_step
      step = @p.step
      logger.info "[play] Start Quiz(#{@p.id})"
    elsif d = params[:decision].presence
      @p.decide(step, Integer(d))
      logger.info "[play] Decide Q_#{step} <- #{d} Quiz(#{@p.id})"
    elsif params[:next]
      @p.next_step
      step = @p.step
      logger.info "[play] Next #{step} Quiz(#{@p.id})"
    end
    redirect_to play_play_path(@p, step)
  end

  def result
    @p = Play.find(params[:id])
    unless @p.finished?
      redirect_to play_play_path(@p)
      return
    end
    render
  end

  def result_chart
    @p = Play.find(params[:id])
    unless @p.finished?
      redirect_to play_play_path(@p)
      return
    end
    render layout: 'chart'
  end

  private

  # :: Int
  def get_step
    params[:step].presence.try(&:to_i) || @p.step
  end
end

