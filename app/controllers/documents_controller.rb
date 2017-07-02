class DocumentsController < ApplicationController
  
  before_action :authorize, :except => [:show,:show_doc_modal]
  respond_to :js, :html

  def index
    @documents = Document.where(user_id: get_current_user)
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.user_id = get_current_user.id
    if @document.save
      flash[:msg] = "Added Document"
    else
      render 'new'
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    if @document.update(document_params)
      flash[:msg] = "Updated Successfully"
    else
      render 'edit'
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  def show_doc_modal
    @document = Document.find(params[:id])
  end

  def search
    @documents = Document.search_user(get_current_user.id,params[:search])
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    flash[:msg] = "Deleted Document"
  end

  def confirm_delete
    @document = Document.find(params[:id])
  end

  private
  def document_params
    params.require(:document).permit(:title,:doc)
  end
end