babel = node_modules/babel/bin/babel/index.js
uglifyjs = node_modules/uglify-js/bin/uglifyjs
cleancss = node_modules/clean-css/bin/cleancss

build:
	@echo "building..."
	@rm -fr app/src; cp -r lib app/src
	@$(babel) app/src/js/index.js --out-file app/src/js/index.js
	@$(uglifyjs) app/src/js/index.js --screw-ie8 -m -o app/src/js/index2.js
	@$(cleancss) app/src/css/index.css -o app/src/css/index.css
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

.PHONY:	clean
