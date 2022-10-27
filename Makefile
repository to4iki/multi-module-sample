SWIFT_RUN=swift run -c release --package-path BuildTool
SWIFT_BUILD_OUT:=./BuildTool/.build/release
WORKSPACE=MultiModuleSample.xcworkspace

export PATH += :$(SWIFT_BUILD_OUT)

.PHONY: open
open:
	open $(WORKSPACE)

.PHONY: bootstrap
bootstrap:
	$(SWIFT_RUN) mint bootstrap

.PHONY: format
format:
	$(SWIFT_RUN) swift-format -r ./MultiModuleSample -i
	$(SWIFT_RUN) swift-format -r ./AppPackage -i
	$(SWIFT_RUN) swift-format -r ./Demo.swiftpm -i

.PHONY: sourcery
sourcery:
	$(SWIFT_RUN) mint run sourcery \
					--sources AppPackage/Sources/Environment \
					--templates Template/ViewResolverTemplate.stencil \
					--output AppPackage/Sources/Environment/Generated/ViewResolver.swift
	$(SWIFT_RUN) mint run sourcery \
					--sources AppPackage/Sources/Environment \
					--templates Template/AppEnvironmentTemplate.stencil \
					--output MultiModuleSample/App/Generated/AppEnvironment+EnvironmentType.swift
