.ONESHELL:
all:

#SIGH npm
npm:
	npm i

# Generate static files
build:
	# make the dist dir if it doesn't exist
	mkdir -p dist
	
	# Convert pug to html
	pug ./src --out ./dist

	# Convert less to css
	lessc ./src/styles/main.less ./dist/styles/main.css

	# move fonts
	cp -r ./src/fonts ./dist

# Delete static files
clean:
	rm -rf ./dist

# Build everything and serve it locally
dev: build
	cd ./dist; \
		python -m SimpleHTTPServer 8080
