class AccountsController < ApplicationController
  before_filter :require_current_user

  def show
  end

  def transfer
    score = get_verify_score
    if score && ThisData::Score::RISK_LEVEL_GREEN.eql?(score.risk_level)
      redirect_to account_path, notice: "Your transfer was successful!"
      session["user"]["balance"] = 0
    else
      redirect_to account_path, error: "Sorry! This transfer has been blocked, because #{score.triggers.to_sentence}."
    end
  end

  private
    def require_current_user
      unless current_user
        redirect_to root_path, error: "Please log in"
      end
    end

    # Uses ThisData's gem to get a risk score for this action
    def get_verify_score
      payload = {
        ip:         current_ip,
        user_agent: current_user_agent,
        user: {
          id: current_user.id
        }
      }
      ThisData.verify(payload)
    end
end
