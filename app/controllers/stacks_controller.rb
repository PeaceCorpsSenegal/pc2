class StacksController < ApplicationController
  
  before_filter :authenticate
  before_filter :authenticate_admin, :only => [ :index ]
  before_filter :authorized_user, :only => [ :destroy ]
  
  # GET /stacks
  # GET /stacks.json
  def index
    @stacks = Stack.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stacks }
    end
  end

  # GET /stacks/new
  # GET /stacks/new.json
  def new
    @stack = Stack.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stack }
    end
  end

  # POST /stacks
  # POST /stacks.json
  def create
    @stack = Stack.new(params[:stack])
    @stack.user_id = current_user.id

    respond_to do |format|
      if @stack.save
        format.html { redirect_to @stack, notice: 'Stack was successfully created.' }
        format.json { render json: @stack, status: :created, location: @stack }
      else
        format.html { render action: "new" }
        format.json { render json: @stack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stacks/1
  # DELETE /stacks/1.json
  def destroy
    @stack = Stack.find(params[:id])
    @stack.destroy

    respond_to do |format|
      format.html { redirect_to stacks_url }
      format.json { head :ok }
    end
  end
  
  private
  
    def authorized_user
      @stack = current_user.stacks.find_by_id(params[:id])
      deny_owner unless !@stack.nil? || current_user.admin?
    end
end
