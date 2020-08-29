# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( brands.scss )
Rails.application.config.assets.precompile += %w( cards.scss )
Rails.application.config.assets.precompile += %w( categorys.scss )
Rails.application.config.assets.precompile += %w( destinations.scss )
Rails.application.config.assets.precompile += %w( images.scss )
Rails.application.config.assets.precompile += %w( products.scss )
Rails.application.config.assets.precompile += %w( users.scss )
Rails.application.config.assets.precompile += %w( purchase.scss )
Rails.application.config.assets.precompile += %w( _footer.scss )
Rails.application.config.assets.precompile += %w( _product-list.scss )
Rails.application.config.assets.precompile += %w( _top-page.scss )
Rails.application.config.assets.precompile += %w( signup.scss )
Rails.application.config.assets.precompile += %w( _footer.scss )
Rails.application.config.assets.precompile += %w( _destroy-page.scss )
Rails.application.config.assets.precompile += %w( products-show.scss )