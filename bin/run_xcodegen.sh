if [ -x "$(command -v xcodegen)" ]; then
  xcodegen generate
else
  echo "XcodeGen not installed, download from https://github.com/yonaskolb/XcodeGen"
fi
