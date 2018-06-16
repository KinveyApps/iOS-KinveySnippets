all: build
	
build:
	cd devcenter-snippets-collector; \
	swift build; \
	.build/x86_64-apple-macosx10.10/debug/devcenter-snippets-collector ../../devcenter ../CodeSnippets.swift
	cd SanityTest; \
	xcodebuild -workspace SanityTest.xcworkspace -scheme SanityTest -sdk iphonesimulator -configuration Debug | xcpretty

clean:
	echo "#error(\"Please run the devcenter-snippets-collector tool first\")" > CodeSnippets.swift

git-clone:
	cd ..; \
	git clone git@github.com:Kinvey/devcenter.git
