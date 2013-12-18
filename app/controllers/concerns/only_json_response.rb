module OnlyJsonResponse
  extend ActiveSupport::Concern

  private
  def create_response(&block)
    respond_to do |format|
      format.html { render status: :forbidden, text: 'Only json allowed'}
      format.json &block
    end
  end

end