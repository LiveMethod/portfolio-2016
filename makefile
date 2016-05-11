.ONESHELL:
all:

#SIGH npm
npm:
	npm i

# Start the harp server for development,
# without building anything
dev:
	cd ./src; \
		harp server

# Generate static files
build:
	# make the dist dir if it doesn't exist
	mkdir -p dist
	
	# THIS IS HACKY:
	# Jade lang became Pug, but Harp server doesn't
	# support compiling .pug files yet.

	# Source files are in Jade so that Harp plays nice with them,
	# but they get duplicated as temporary .pug files during
	# build, compiled from pug to html into src, then the
	# temporary .pug files are deleted. ... shhh ... I know. 

	mkdir -p temp

	cp -r ./src/*.jade ./temp

	cd ./temp; \
		for i in ./*.jade; do mv "$$i" "$${i/.jade}".pug; done

	pug ./temp --out ./dist

	rm -rf ./temp

	# Convert less to css
	lessc ./src/main.less ./dist/css/main.css

	# move fonts
	cp -r ./src/fonts ./dist

# Delete static files
clean:
	rm -rf ./temp
	rm -rf ./dist

# for i in ./*.jade; do mv "$i" "${i/.jade}".pug; done
