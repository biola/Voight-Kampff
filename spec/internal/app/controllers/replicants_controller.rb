class ReplicantsController < ActionController::Base
  def index
    header = "Replicants:\n===========\n"

    status, content = if request.bot?
      [200, '- Rick Deckard']
    else
      [403, 'No replicants here']
    end

    render plain: header + content, status: status
  end
end
