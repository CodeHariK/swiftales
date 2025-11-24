# NavigationCookbook Development Makefile
# Swift formatting and build commands

SWIFT_FORMAT = swift-format
SWIFT_FORMAT_CONFIG = .swift-format
SWIFT_FILES = $(shell find . -name "*.swift" -type f)
PROJECT = NavigationCookbook.xcodeproj
SCHEME = NavigationCookbook

.PHONY: help format format-check lint build build-macos run run-standalone clean

help:
	@echo "NavigationCookbook Development Commands:"
	@echo ""
	@echo "Formatting:"
	@echo "  make format        - Format all Swift files with 4-space indentation"
	@echo "  make format-check  - Check formatting without modifying files"
	@echo "  make lint          - Lint Swift files for style issues"
	@echo ""
	@echo "Build:"
	@echo "  make build         - Build for macOS"
	@echo "  make build-macos   - Build for macOS (explicit)"
	@echo "  make build-ios     - Build for iOS Simulator"
	@echo "  make clean         - Clean build artifacts"
	@echo ""
	@echo "Run:"
	@echo "  make run           - Build and run on macOS"
	@echo "  make run-standalone - Build and run with standalone hot reload (no InjectionIII app needed)"
	@echo ""
	@echo "Configuration:"
	@echo "  Swift format config: $(SWIFT_FORMAT_CONFIG)"
	@echo "  Project: $(PROJECT)"
	@echo "  Scheme: $(SCHEME)"

# Format all Swift files
format:
	@echo "=== Formatting Swift files ==="
	@find . -name "*.swift" -type f -exec $(SWIFT_FORMAT) format --configuration $(SWIFT_FORMAT_CONFIG) --in-place {} \;
	@echo "Formatting complete!"

# Check formatting without modifying files
format-check:
	@echo "=== Checking Swift file formatting ==="
	@find . -name "*.swift" -type f -exec $(SWIFT_FORMAT) format --configuration $(SWIFT_FORMAT_CONFIG) {} \; > /dev/null
	@echo "Format check complete!"

# Lint Swift files
lint:
	@echo "=== Linting Swift files ==="
	@find . -name "*.swift" -type f -exec $(SWIFT_FORMAT) lint --configuration $(SWIFT_FORMAT_CONFIG) {} \;

# Build for iOS Simulator
build-ios:
	@echo "=== Building for iOS Simulator ==="
	@xcodebuild -project $(PROJECT) -scheme $(SCHEME) -destination 'platform=iOS Simulator,name=iPhone 15' build
	@echo "Build complete!"

# Clean build artifacts
clean:
	@echo "=== Cleaning build artifacts ==="
	@xcodebuild -project $(PROJECT) -scheme $(SCHEME) clean
	@echo "Clean complete!"

# Build and run on macOS (extracts app path from build output)
run:
	@echo "=== Building and running app on macOS ==="
	@BUILD_OUTPUT=$$(xcodebuild -project $(PROJECT) -scheme $(SCHEME) -destination 'platform=macOS' build 2>&1); \
	BUILD_STATUS=$$?; \
	if [ $$BUILD_STATUS -eq 0 ]; then \
		APP_PATH=$$(echo "$$BUILD_OUTPUT" | grep -E "RegisterWithLaunchServices.*\.app" | tail -1 | sed -E 's/.*RegisterWithLaunchServices[[:space:]]+([^[:space:]]+\.app).*/\1/'); \
		if [ -z "$$APP_PATH" ]; then \
			APP_PATH=$$(echo "$$BUILD_OUTPUT" | grep -E "builtin-validationUtility.*\.app" | tail -1 | sed -E 's/.*builtin-validationUtility[[:space:]]+([^[:space:]]+\.app).*/\1/'); \
		fi; \
		if [ -n "$$APP_PATH" ] && [ -d "$$APP_PATH" ]; then \
			echo "Build complete! Launching app..."; \
			open "$$APP_PATH"; \
			echo "App launched at: $$APP_PATH"; \
		else \
			echo "Build succeeded but could not find app path in build output."; \
			echo "Trying default location..."; \
			DEFAULT_PATH="/Users/a24/Library/Developer/Xcode/DerivedData/NavigationCookbook-drsjqhxizninmnbdcyqstozhbltm/Build/Products/Debug/$(SCHEME).app"; \
			if [ -d "$$DEFAULT_PATH" ]; then \
				open "$$DEFAULT_PATH"; \
				echo "App launched at: $$DEFAULT_PATH"; \
			else \
				echo "Error: App not found. Please check build output."; \
				exit 1; \
			fi; \
		fi; \
		else \
			echo "Build failed!"; \
			exit $$BUILD_STATUS; \
		fi

# Build and run with standalone hot reload (no InjectionIII app needed)
run-standalone:
	@echo "=== Building and running app on macOS (Standalone Hot Reload) ==="
	@BUILD_OUTPUT=$$(xcodebuild -project $(PROJECT) -scheme $(SCHEME) -destination 'platform=macOS' build 2>&1); \
	BUILD_STATUS=$$?; \
	if [ $$BUILD_STATUS -eq 0 ]; then \
		APP_PATH=$$(echo "$$BUILD_OUTPUT" | grep -E "RegisterWithLaunchServices.*\.app" | tail -1 | sed -E 's/.*RegisterWithLaunchServices[[:space:]]+([^[:space:]]+\.app).*/\1/'); \
		if [ -z "$$APP_PATH" ]; then \
			APP_PATH=$$(echo "$$BUILD_OUTPUT" | grep -E "builtin-validationUtility.*\.app" | tail -1 | sed -E 's/.*builtin-validationUtility[[:space:]]+([^[:space:]]+\.app).*/\1/'); \
		fi; \
		if [ -n "$$APP_PATH" ] && [ -d "$$APP_PATH" ]; then \
			echo "Build complete! Launching app with standalone hot reload..."; \
			INJECTION_STANDALONE=1 open "$$APP_PATH"; \
			echo "App launched at: $$APP_PATH"; \
			echo "Hot reload enabled in standalone mode (no InjectionIII app needed)"; \
		else \
			echo "Build succeeded but could not find app path in build output."; \
			echo "Trying default location..."; \
			DEFAULT_PATH="/Users/a24/Library/Developer/Xcode/DerivedData/NavigationCookbook-drsjqhxizninmnbdcyqstozhbltm/Build/Products/Debug/$(SCHEME).app"; \
			if [ -d "$$DEFAULT_PATH" ]; then \
				INJECTION_STANDALONE=1 open "$$DEFAULT_PATH"; \
				echo "App launched at: $$DEFAULT_PATH"; \
				echo "Hot reload enabled in standalone mode"; \
			else \
				echo "Error: App not found. Please check build output."; \
				exit 1; \
			fi; \
		fi; \
	else \
		echo "Build failed!"; \
		exit $$BUILD_STATUS; \
	fi

