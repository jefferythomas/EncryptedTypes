if [ -x "$(command -v swiftlint)" ]; then
  swiftlint
else
  echo "SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
