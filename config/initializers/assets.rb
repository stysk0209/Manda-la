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
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# JavaScript読み込みのため記述しています。
Rails.application.config.assets.precompile += %w( modal_window.js )
Rails.application.config.assets.precompile += %w( mandalas_new.js )
Rails.application.config.assets.precompile += %w( normalize.scss )
Rails.application.config.assets.precompile += %w( todo_list.js )
Rails.application.config.assets.precompile += %w( graph.js )
Rails.application.config.assets.precompile += %w( mandala_mypage.js )

