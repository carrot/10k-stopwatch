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
	@uglifyjs app/src/js/index.js --screw-ie8 -m -o app/src/js/index2.js
	@cleancss app/src/css/index.css -o app/src/css/index.css
	@rm app/src/js/index.js
	@touch app/src/js/index.js
	@cat app/src/js/carrot.js >> app/src/js/index.js
	@cat app/src/js/index2.js >> app/src/js/index.js
	@rm app/src/js/index2.js
	@rm app/src/js/carrot.js
	@echo "done!"

clean:
	@echo "cleaning up your mess..."
	rm -fr app/src
	@echo "done!"

.PHONY: clean
