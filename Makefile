build:
	@if [ ! -d "node_modules" ]; then \
		echo "installing dependencies..."; \
		npm install; \
		npm install uglify-js -g; \
		npm install clean-css -g; \
		echo ""; \
	fi

	@echo "building..."
	@rm -fr app/src; cp -r lib app/src
	@coffee -c app/src/js/index.coffee
	@rm app/src/js/index.coffee
	@uglifyjs app/src/js/index.js --screw-ie8 -m -o app/src/js/index.js
	@cleancss app/src/css/index.css -o app/src/css/index.css
	@echo "done!"

clean:
	@echo "cleaning up your mess..."
	rm -fr app/src
	@echo "done!"

.PHONY: clean
