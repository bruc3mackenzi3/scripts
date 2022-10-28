PATH_SUFFIX="\
:/opt/homebrew/Cellar/kubernetes-cli/1.25.3/bin/\
:/opt/homebrew/Cellar/maven/3.8.6/bin/"
export PATH=$PATH$PATH_SUFFIX

if [ -z "$GOPRIVATE" ]
then
    OLD_GOPRIVATE="$GOPRIVATE,"
fi
export GOPRIVATE="$OLD_GOPRIVATE\
github.com/fl-vod,\
github.com/fl-vod-gcp,\
github.com/fl-media,\
github.com/fl-edge-service"
