build:
	@if [ ! -d "node_modules" ]; then \
		echo "installing dependencies..."; \
		npm install; \
		echo ""; \
	fi

	@echo "building..."
	@rm -fr src; cp -r lib src
	@coffee -c src/js/index.coffee
	@rm src/js/index.coffee
	@uglifyjs src/js/index.js --screw-ie8 -o src/js/index.js
	@cleancss src/css/index.css -o src/css/index.css
	@cp manifest.json src/manifest.json
	@echo "done!"

clean:
	@echo "cleaning up your mess..."
	rm -fr src
	@echo "done!"

.PHONY: clean
