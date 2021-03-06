module Admin
  class MembersController < ::MembersController
    http_basic_authenticate_with MembershipRegister.basic_auth_options

    respond_to :csv, only: :index

    def index
      @members = Member.all.order(updated_at: :desc)
      respond_with @members
    end

    def create
      @member = Member.new(member_params)
      @member.save
      respond_with :admin, @member
    end

    def update
      @member.update(member_params)
      respond_with :admin, @member
    end

  private

    def token_valid?
      true
    end

    def member_params
      params.require(:member).permit(:full_name, :email, :address, :joined_at)
    end

  end
end
