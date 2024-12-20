.PHONY: build test package clean

build:
	poetry install

test:
	poetry run aa-watcher-input --help  # Ensures that it at least starts
	make typecheck

typecheck:
	poetry run mypy src/aa_watcher_input --ignore-missing-imports

build-vis:
	#npm install -g pug-cli browserify
	cd visualization && make build

package:
	pyinstaller aa-watcher-input.spec --clean --noconfirm
	# if dist/visualization/dist exists, include in package
	if [ -d "visualization/dist" ]; then \
		mkdir -p dist/visualization; \
		cp -r visualization/dist/* dist/visualization; \
	fi

clean:
	rm -rf build dist
	rm -rf aa_watcher_input/__pycache__
