class ReplicantsController < ActionController::Base
  def index
    header = "Replicants:\n===========\n"

    content = if request.bot?
      '- Rick Deckard'
    else
      'No replicants here'
    end

    render plain: header + content
  end
end
