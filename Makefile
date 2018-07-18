all: build
	
build:
	cd devcenter-snippets-collector; \
	swift build; \
	swift run devcenter-snippets-collector ../../devcenter ../CodeSnippets.swift
	cd SanityTest; \
	xcodebuild -workspace SanityTest.xcworkspace -scheme SanityTest -sdk iphonesimulator -configuration Debug | xcpretty

clean:
	echo "#error(\"Please run the devcenter-snippets-collector tool first\")" > CodeSnippets.swift

git-clone:
	cd ..; \
	git clone git@github.com:Kinvey/devcenter.git
