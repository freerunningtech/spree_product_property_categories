module Spree
  class PropertyCategoryRequest
    def initialize(params, product)
      @params = params
      @product = product
    end

    def properties
      properties = []
      @params.values.each do |category|
        next unless category[:properties]
        category[:properties].values.each_with_index do |pp, i|
          next if pp[:key].blank?
          properties << {
            product: @product,
            property_name: pp[:key],
            value: pp[:value],
            position: i,
            product_property_category_attributes: {
              position: 0,
              property_category_attributes: {
                name: category[:name].blank? ?
                Spree.t(:default_category_name) :
                category[:name]
              }
            }
          }
        end
      end
      properties
    end
  end
end
