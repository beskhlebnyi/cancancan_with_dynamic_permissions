class ItemController < ApplicationController
  authenticate_user!
  load_and_authorize_resource
  before_filter :load_permissions

  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  def new
    @parts = Part.all
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  def create
    @parts = Part.all
    #@item = Item.new(params[:item])
    @item = Item.new(params.require(:item).permit(:name,:number))

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
  private
      def item_params
        #params.require(:part).permit(:name)
        params.require(:item).permit(:name, :number)
end
end
