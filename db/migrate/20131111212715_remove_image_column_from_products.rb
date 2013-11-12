class RemoveImageColumnFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :image_id
  end
end
