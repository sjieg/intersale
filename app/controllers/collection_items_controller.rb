class CollectionItemsController < ApplicationController
  before_action :set_collection_item, only: %i[show edit update destroy]
  before_action :set_collection, only: %i[index new create]
  before_action :set_paper_trail_whodunnit

  # GET /collection_items
  def index
    @collection_items = policy_scope(CollectionItem)
  end

  # GET /collection_items/1
  def show
  end

  # GET /collection_items/new
  def new
    @collection_item = CollectionItem.new(collection: @collection, availability: :available)
    authorize @collection_item
  end

  # GET /collection_items/1/edit
  def edit
  end

  # POST /collection_items
  def create
    @collection_item = CollectionItem.new(collection_item_params)
    authorize @collection_item

    if @collection_item.save
      redirect_to @collection_item, notice: "Collection item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /collection_items/1
  def update
    if @collection_item.update(collection_item_params)
      redirect_to @collection_item, notice: "Collection item was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /collection_items/1
  def destroy
    @collection_item.destroy!
    redirect_to collection_items_url, notice: "Collection item was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_collection_item
    @collection_item = CollectionItem.find(params[:id])
    authorize @collection_item
  end

  def set_collection
    @collection = Collection.find_by(id: params[:collection_id]) || policy_scope(Collection)
  end

  # Only allow a list of trusted parameters through.
  def collection_item_params
    params.require(:collection_item).permit(:collection_id, :title, :description, :value, :height_mm, :width_mm, :depth_mm, :availability, images: [])
  end
end
