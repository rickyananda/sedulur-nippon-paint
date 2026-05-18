require 'sinatra'
require 'json'

configure do
  set :views, File.join(File.dirname(__FILE__), 'views')
  set :public_folder, File.join(File.dirname(__FILE__), 'public')
  set :erb, layout: :'layouts/app'
end

# Load product data
PRODUCTS = JSON.parse(File.read(File.join(File.dirname(__FILE__), 'data/products.json')))
PRICES   = JSON.parse(File.read(File.join(File.dirname(__FILE__), 'data/prices.json')))

get '/' do
  @title = 'Toko SEDULUR - Dealer Resmi Nippon Paint Surabaya'
  @products = PRODUCTS
  erb :'pages/home'
end

get '/produk' do
  @title = 'Produk - Toko SEDULUR'
  @products = PRODUCTS
  @category = params[:kategori]
  erb :'pages/produk'
end

get '/harga' do
  @title = 'Daftar Harga - Toko SEDULUR'
  @prices = PRICES
  @category = params[:kategori] || 'semua'
  erb :'pages/harga'
end

get '/tentang' do
  @title = 'Tentang Kami - Toko SEDULUR'
  erb :'pages/tentang'
end

get '/kontak' do
  @title = 'Kontak - Toko SEDULUR'
  erb :'pages/kontak'
end

post '/order' do
  produk  = params[:produk]
  kemasan = params[:kemasan]
  jumlah  = params[:jumlah]
  nama    = params[:nama]
  msg = "Halo, saya #{nama} ingin memesan:\nProduk: #{produk}\nKemasan: #{kemasan}\nJumlah: #{jumlah}"
  redirect "https://wa.me/6287843954886?text=#{URI.encode_www_form_component(msg)}"
end
