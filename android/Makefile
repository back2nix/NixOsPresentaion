AVD_ID:=Pixel_API_34

OPTS := \
    -shell \
    -writable-system \
    -skip-adb-auth \
    -show-kernel \
    -camera-front none \
    -camera-back none \
    -no-audio \
    -no-sim \
    -no-passive-gps \
    -netdelay none \
    -verbose \
    -no-boot-anim \
    -no-snapshot \
    -gpu auto \
    -memory 2048 \
    -partition-size 2048 \
    -dns-server 8.8.8.8
    # -no-window \
    # -http-proxy http://myproxy.example.com:1234


run/android:
	emulator -avd "$(AVD_ID)" -id $(AVD_ID) $(OPTS)

develop:
	@ nix develop --ignore-environment \
		--keep LC_NUMERIC \
		--keep LC_TIME \
		--keep HOME \
		--keep TERM \
		--keep COLORTERM \
		--keep TERM_PROGRAM \
		--keep TERM_PROGRAM_VERSION \
		--keep DISPLAY \
		--keep XAUTHORITY \
		--keep USERNAME \
		--keep DOCKER_HOST \
		--keep DESKTOP_SESSION \
		--keep DBUS_SESSION_BUS_ADDRESS
