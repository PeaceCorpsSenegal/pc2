class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
    @title = 'Listing Pages'
    @context_menu = {'new' => new_page_path, 'feed' => feed_pages_path}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  def feed
    @pages = Page.order('updated_at DESC').paginate(:page => params[:page])
    @title = 'Page Feed'
    @context_menu = {'back' => pages_path}
    render 'feed'
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])
    @title = @page.title
    @context_menu = {'back' => pages_path, 'new' => new_page_path, 'edit' => edit_page_path}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new
    @title = 'New Page'
    @context_menu = {'cancel' => pages_path}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
    @title = @page.title
    @context_menu = {'back' => pages_path, 'new' => new_page_path, 'cancel' => page_path}

  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        @page.set_parent
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        @page.set_parent
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :ok }
    end
  end
end
