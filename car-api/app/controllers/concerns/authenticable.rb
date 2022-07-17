module Authenticable
  def current_user
    return @current_user if @current_user

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded =  begin JsonWebToken.decode(header)
    rescue JWT::DecodeError
      head :unauthorized
    end

    @current_user = begin
      User.find(decoded[:user_id])
    rescue StandardError
      ActiveRecord::RecordNotFound
    end
  end

  protected

  def check_login
    head :unauthorized unless self.current_user
  end
end
