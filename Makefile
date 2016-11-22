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

cocoapods-install:
	cd 3x/Swift-3; \
	pod install --repo-update
	
	cd 3x/Swift-2.3; \
	pod install --repo-update

build: cocoapods-install
	cd 3x/Swift-3; \
	xcodebuild -workspace KinveySnippet.xcworkspace -scheme KinveySnippet OBJROOT=${CURDIR}/build SYMROOT=${CURDIR}/build clean build | xcpretty
	
	cd 3x/Swift-2.3; \
	xcodebuild -workspace KinveySnippet.xcworkspace -scheme KinveySnippet OBJROOT=${CURDIR}/build SYMROOT=${CURDIR}/build clean build | xcpretty
