class UserManagement::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /user_management/users
  # GET /user_management/users.json
  def index
    relation_object = RelationObject.scoped_relation_object(
                        scope_name: params[:scope],
                        klass: User
                      )

    @users = Paginate.get_records(
      relation_object:  relation_object,
      page:             params[:page] || DEFAULT_PAGE,
      per_page:         params[:per_page] || DEFAULT_PER_PAGE
    )
  end

  # GET /user_management/users/1
  # GET /user_management/users/1.json
  def show
  end

  # GET /user_management/users/new
  def new
    @user = User.new
  end

  # GET /user_management/users/1/edit
  def edit
  end

  # POST /user_management/users
  # POST /user_management/users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to [:user_management, @user], notice: t("model.create", kind: "User") }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_management/users/1
  # PATCH/PUT /user_management/users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params_on_edit)
        format.html { redirect_to [:user_management, @user], notice: t("model.update", kind: "User") }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_management/users/1
  # DELETE /user_management/users/1.json
  def destroy
    @user.disable
    respond_to do |format|
      format.html { redirect_to user_management_users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.unscoped.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :username, :email, :password,
        :password_confirmation
      )
    end

    def user_params_on_edit
      if params[:update_password] == "yes"
        user_params
      else
        params.require(:user).permit(
        :username, :email
      )
      end
    end
end
