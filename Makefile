all: build

clean:
	rm -Rf build
	
	rm -Rf 3x/Swift-3/Pods
	rm -Rf 3x/Swift-3/Podfile.lock
	rm -Rf 3x/Swift-3/build
	
	rm -Rf 3x/Swift-2.3/Pods
	rm -Rf 3x/Swift-2.3/Podfile.lock
	rm -Rf 3x/Swift-2.3/build
	
	rm -Rf 1x/ObjC/Pods
	rm -Rf 1x/ObjC/Podfile.lock
	rm -Rf 1x/ObjC/build
	
	rm -Rf 1x/Swift-3/Pods
	rm -Rf 1x/Swift-3/Podfile.lock
	rm -Rf 1x/Swift-3/build
	
	rm -Rf 1x/Swift-2.3/Pods
	rm -Rf 1x/Swift-2.3/Podfile.lock
	rm -Rf 1x/Swift-2.3/build
	
	rm -Rf SanityTest/Carthage/KinveyCarthageTest-Develop/Carthage
	rm -Rf SanityTest/Carthage/KinveyCarthageTest-Develop/Cartfile.resolved
	rm -Rf SanityTest/Carthage/KinveyCarthageTest-Latest/Carthage
	rm -Rf SanityTest/Carthage/KinveyCarthageTest-Latest/Cartfile.resolved

cocoapods-install:
	cd 3x/Swift-3; \
	pod install --repo-update
	
	cd 3x/Swift-2.3; \
	pod install --repo-update
	
carthage-boostrap:
	cd SanityTest/Carthage/KinveyCarthageTest-Develop; \
	carthage bootstrap --platform ios --no-use-binaries
	
	cd SanityTest/Carthage/KinveyCarthageTest-Latest; \
	carthage bootstrap --platform ios --no-use-binaries

build: cocoapods-install carthage-boostrap build-only
	
build-only:
	cd 3x/Swift-3; \
	xcodebuild -workspace KinveySnippet.xcworkspace -scheme KinveySnippet clean build | xcpretty
	
	cd 3x/Swift-2.3; \
	xcodebuild -workspace KinveySnippet.xcworkspace -scheme KinveySnippet clean build | xcpretty
	
	cd SanityTest/Carthage/KinveyCarthageTest-Develop; \
	xcodebuild clean build | xcpretty
	
	cd SanityTest/Carthage/KinveyCarthageTest-Latest; \
	xcodebuild clean build | xcpretty
