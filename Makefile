.PHONY: setup run

setup:
	flutter pub get
	cd example && flutter pub get

run:
	cd example && flutter run -d chrome
