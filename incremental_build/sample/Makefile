.PHONY: configure
configure:
	mkdir -p build; \
		cd build && \
	cmake -DCMAKE_BUILD_TYPE=Debug ..

.PHONY: build
build:
	cd build && \
		make

clean:
	rm -rf build
