class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.save

    categoria = [
       "Perfumes", "Libros", "Tecnología", "Electrodomésticos", "Aseo", "Jugetes", "Ropa", "Oficina", "Mascotas"
    ]

    params.keys.each do |para|
      if categoria.include?(para)
        @product.categories.push(Category.find_by(name: para))
      end
    end

    redirect_to products_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)

    categoria = [
       "Perfumes", "Libros", "Tecnología", "Electrodomésticos", "Aseo", "Jugetes", "Ropa", "Oficina", "Mascotas"
    ]

    @product.categories.delete_all

    params.keys.each do |para|
      if categoria.include?(para)
        @product.categories.push(Category.find_by(name: para))
      end
    end

    redirect_to products_path
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:name, :price)
  end

end
