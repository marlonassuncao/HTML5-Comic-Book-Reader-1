
#
# build package & update examples
#

build:
	@echo "Compiling Handlebars templates..."
	@./node_modules/.bin/handlebars templates/*.handlebars -f lib/templates.js
	@echo "Compiling and minifying javascript..."
	@mkdir -p comicbook/js/pixastic
	@cat lib/vendor/pixastic/pixastic.js lib/vendor/pixastic/pixastic.effects.js lib/vendor/pixastic/pixastic.worker.js lib/vendor/handlebars.runtime-1.0.rc.1.min.js lib/templates.js lib/ComicBook.js > comicbook/js/comicbook.js
	@cp lib/vendor/pixastic/pixastic.js comicbook/js/pixastic
	@cp lib/vendor/pixastic/pixastic.effects.js comicbook/js/pixastic
	@cp lib/vendor/pixastic/pixastic.worker.js comicbook/js/pixastic
	@cp lib/vendor/pixastic/pixastic.worker.control.js comicbook/js/pixastic
	@cp lib/vendor/pixastic/license-gpl-3.0.txt comicbook/js/pixastic
	@cp lib/vendor/pixastic/license-mpl.txt comicbook/js/pixastic
	@./node_modules/.bin/uglifyjs comicbook/js/comicbook.js --compress --mangle --screw-ie8 --output comicbook.min.js --source-map comicbook/js/comicbook.min.js.map --source-map-root ./
	@echo "Compiling CSS..."
	@cat fonts/icomoon-toolbar/style.css css/reset.css css/styles.css css/toolbar.css > comicbook/comicbook.css
	@./node_modules/.bin/cssmin comicbook/comicbook.css > comicbook/comicbook.min.css
	@echo "Copying assets..."
	@cp -r css/img comicbook/img
	@cp -r icons/1_Desktop_Icons/icon_128.png comicbook/img
	@cp -r icons/1_Desktop_Icons/icon_196.png comicbook/img
	@cp -r fonts/icomoon-toolbar/fonts comicbook
	@cp -r fonts/icomoon-toolbar/license.txt comicbook/fonts
	@echo "Updating examples"
	@cp -r comicbook examples
	@echo "Done"


#
# remove prior builds
#

clean:
	@rm -r comicbook
	@rm -r examples/comicbook
	@rm lib/templates.js
