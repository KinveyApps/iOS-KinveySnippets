all: build

clean:
	rm -Rf build

cocoapods-install:
	cd 3x/Swift-3; \
	pod install
	
	cd 3x/Swift-2.3; \
	pod install

build: cocoapods-install
	cd 3x/Swift-3; \
	xcodebuild -workspace KinveySnippet.xcworkspace -scheme KinveySnippet OBJROOT=${CURDIR}/build SYMROOT=${CURDIR}/build clean build
	
	cd 3x/Swift-2.3; \
	xcodebuild -workspace KinveySnippet.xcworkspace -scheme KinveySnippet OBJROOT=${CURDIR}/build SYMROOT=${CURDIR}/build clean build
