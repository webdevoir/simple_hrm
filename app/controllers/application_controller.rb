class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user_type, :pagination_params, :current_entity,
                :show_recaptcha?, :exceded_max_login_attempts?, :can_reset_password?,
                :description_for, :paginated_records_for


  def after_sign_in_path_for(resource)
    root_url
  end

  protected

  def verify_xhr
    unless request.xhr?
      render text: "Invalid request!"
    end
  end

  def paginated_records_for(klass)
    Paginate.get_records(
        relation_object:  klass,
        page:             params[:page],
        per_page:         params[:per_page]
      )
  end

  def build_address_for(object)
    object.build_address
  end

  def set_flash_messages(type: "", message: "")
    return unless request.xhr?

    response.headers['X-Message'] = message
    response.headers["X-Message-Type"] = type

    flash.discard
  end

  private

  def current_user_type
    AppEnumerables::Entites.each do |entity|
      desc = entity.description
      return desc if send :"current_#{desc}"
    end

    return "visitor"
  end

  def pagination_params
    {
      scope: params[:scope],
      page: params[:page],
      per_page: params[:per_page]
    }
  end

  def show_recaptcha?
    if captacha_enabled? && exceded_max_login_attempts?
      true
    else
      false
    end
  end

  def exceded_max_login_attempts?
    if cookies[:attempts].to_i > max_login_attempts
      true
    else
      false
    end
  end

  def captacha_enabled?
    authentication_config.show_recaptcha?
  end

  def max_login_attempts
    authentication_config.attempts
  end

  def authentication_config
    @authentication_configuration ||= AuthenticationConfiguration.first
  end

  def can_reset_password?
    authentication_config.can_reset_password?
  end

  def current_entity
    send("current_#{current_user_type}") unless current_user_type == "visitor"
  end

  def description_for(enum_object, value)
    description = nil
    enum_object.each { |e| description = e.description if value == e.value }
    description
  end

end
